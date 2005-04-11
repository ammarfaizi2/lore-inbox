Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVDKRH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVDKRH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDKRH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:07:58 -0400
Received: from hermes.domdv.de ([193.102.202.1]:12804 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261837AbVDKRCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:02:24 -0400
Message-ID: <425AAD95.5000808@domdv.de>
Date: Mon, 11 Apr 2005 19:02:13 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
References: <42592697.8060909@domdv.de> <20050410201455.GA21568@elf.ucw.cz> <200504111237.45452.oliver@neukum.org> <200504111839.50872.rjw@sisk.pl>
In-Reply-To: <200504111839.50872.rjw@sisk.pl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 11 of April 2005 12:37, Oliver Neukum wrote:
> 
>>Am Sonntag, 10. April 2005 22:14 schrieb Pavel Machek:
>>
>>>Hi!
>>>
>>>
>>>>>Oliver Neukum wrote:
>>>>>
>>>>>>What is the point in doing so after they've rested on the disk for ages?
>>>>>
>>>>>The point is not physical access to the disk but data gathering after
>>>>>resume or reboot.
>>>>
>>>>After resume or reboot normal access control mechanisms will work
>>>>again. Those who can read a swap partition under normal circumstances
>>>>can also read /dev/kmem. It seems to me like you are putting an extra
>>>>lock on a window on the third floor while leaving the front door open.
>>>
>>>Andreas is right, his patches are needed.
>>>
>>>Currently, if your laptop is stolen after resume, they can still data
>>>in swsusp image.
>>>
>>>Zeroing the swsusp pages helps a lot here, because at least they are
>>>not getting swsusp image data without heavy tools. [Or think root
>>>compromise month after you used swsusp.]
>>>
>>>Encrypting swsusp image is of course even better, because you don't
>>>have to write large ammounts of zeros to your disks during resume ;-).
>>
>>Not only is it better, it completely supercedes wiping the image.
>>Your laptop being stolen after resume is very much a corner case.
>>You suspend your laptop while you are not around, don't you?
> 
> 
> Not necessarily.  Some people use suspend instead of shutdown. :-)

Now here's what I'm currently doing:

I do usually suspend instead of shutdown. The suspend partition is the
only unencrypted swap partition and it is disabled during regular
operation so it is not used for regular swapping. Except for a small
boot partition without any valuable data all other partitions are encrypted.

The key for dm-crypt setup is stored on an ide flash disk which isn't
inserted during travelling and which is transported separately.

Now let's imagine the laptop gets stolen by an average thief which is
the most common case.Thief needs to know if the laptop is working
because thief wants to sell it so thief powers on the laptop.

swsusp resumes and with the encryption patch renders the suspend image
worthless. The suspend/resume script immediately checks for the presence
of the ide flash disk with the correct key (match is done against the
in-kernel dm-crypt key). If the ide flash disk is not present or if
there is a key mismatch the script shuts the system immediately down, so
the in-kernel key is lost.

The only way for the thief now to access any data on the disk is to come
back and steal the flash disk, too.

When the initrd feature pavel just notified me about comes from mm to
mainline one can additionally protect the swap partition used for
suspend with dm-crypt and collect the key at resume time via initrd.

In this case the disk is then not only protected against the average
thief but also against the professinal one as long as the flash disk is
secure.

And if the laptop is not stolen the encrypted suspend image prevents
against nasty surprises of sensitive data turning up on disk that should
never have been put there in the first place (oh well, but one needs to
suspend from time to time).
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
