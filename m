Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWEYOpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWEYOpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWEYOpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:45:25 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:53754 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1030197AbWEYOpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:45:24 -0400
Message-ID: <4475C2F2.7090207@mandriva.org>
Date: Thu, 25 May 2006 17:45:06 +0300
From: Anssi Hannula <anssi@mandriva.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
References: <20060515211229.521198000@gmail.com>	<20060515211506.783939000@gmail.com>	<20060517222007.2b606b1b.akpm@osdl.org>	<44757246.9010300@mandriva.org> <20060525070017.16344c97.akpm@osdl.org>
In-Reply-To: <20060525070017.16344c97.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi@mandriva.org> wrote:
> 
>> >>+int input_ff_erase(struct input_dev *dev, int id)
>> >>+{
>> >>+	struct ff_device *ff;
>> >>+	unsigned long flags = 0;
>> >>+	int ret;
>> >>+	if (!test_bit(EV_FF, dev->evbit))
>> >>+		return -EINVAL;
>> >>+	mutex_lock(&dev->ff_lock);
>> >>+	ff = dev->ff;
>> >>+	if (!ff) {
>> >>+		mutex_unlock(&dev->ff_lock);
>> >>+		return -ENODEV;
>> >>+	}
>> >>+	spin_ff_cond_lock(ff, flags);
>> >>+	ret = _input_ff_erase(dev, id, current->pid == 0);
>> >>+	spin_ff_cond_unlock(ff, flags);
>> >>+
>> >>+	mutex_unlock(&dev->ff_lock);
>> >>+	return ret;
>> >>+}
>> > 
>> > 
>> > Perhaps you meant `current->uid == 0' here.  There's no way in which pid
>> > 0 will call this code.
>>
>> Right, a silly mistake.
>>
>> > What's happening here anyway?  Why does this code need to know about pids?
>> > 
>> > Checking for uid==0 woud be a fishy thing to do as well.
>>
>> User ID 0 is allowed to delete effects of other users. Pids are used to
>> keep a track of what process owns what effects. This is the same
>> behaviour as before.
> 
> 
> Oh dear.
> 
> Whatever we do here should remain 100%-compatible with "before".  Which
> rather limits our options.

There are only _very_ few programs using FF on Linux ATM, and I don't
think any of them opens multiple fd:s to the same device and expects to
be able to delete effects created on the other fd. And that is the only
con of changing the behaviour.

Should the behaviour be changed so that the effect owners are file
descriptors, the effects of one fd would not be lost if the process
opens and closes another fd on the same device (currently all effects of
a process are deleted if the process closes any fd to the device).

>> There is a problem with this, though:
>> When a process closes any fd to this device, all pid-matching effects
>> are deleted whether the process has another fd using the device or not.
>>
>> One solution would probably be to add some handle parameter to
>> input_ff_upload() and input_ff_erase(), and then in
>> evdev_ioctl_handler() pass an id unique to this fd. Then effects would
>> be fd-specific, not pid-specific. I think the uid == 0 thing can also be
>> dropped... I don't think the root user needs ability to override user
>> effects (it can delete them anyway, just kill the user process owning
>> the effects).
>>
> 
> 
> Generally we use file descriptors (and driver-specific state at
> file.f_private) to manage things like that.  But I'd imagine that we
> couldn't retain the existing semantics with any such scheme.
> 
> A pragmatic approach would be to put a big fat comment in there explaining
> how it all works and leave it at that.

As I don't see this could break any existing applications, I would very
much like to change the behaviour so that the effects are file
descriptor specific. What should I use to differentiate the descriptors?
Can I just compare the "struct file*"? (it seems to work well, I just
modified the code so)

-- 
Anssi Hannula

