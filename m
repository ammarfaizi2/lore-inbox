Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264066AbUEXGj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUEXGj3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbUEXGj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:39:29 -0400
Received: from mail.homelink.ru ([81.9.33.123]:61610 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S264066AbUEXGjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:39:25 -0400
Date: Mon, 24 May 2004 10:39:21 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: class_device_find()
Message-Id: <20040524103921.7957533a.zap@homelink.ru>
In-Reply-To: <20040524051303.GC27371@kroah.com>
References: <20040523002309.2ec5965e.zap@homelink.ru>
	<20040524051303.GC27371@kroah.com>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some time ago there was a discussion about adding an class_device_find()
function. So I have a question about it.

The class_device_find() function returns a pointer to a class_device, but the
reference counter of that object is not incremented. This looks to me somewhat
racy, unless there are some details I'm missing. In my understanding,
class_device_find should be an atomic operation, and the refcount for the
returned object must be incremented prior to returning it, otherwise the
device may disappear before we do something with the returned pointer, and we
end up with a bogus pointer to nowhere.

Another thing I have noted and that looks a little wrong to me is the
sequence of code in class_device_add():

	class_dev = class_device_get(class_dev);
	if (!class_dev || !strlen(class_dev->class_id))
		return -EINVAL;

I would use rather:

	if (!class_dev || !strlen(class_dev->class_id))
		return -EINVAL;
	class_dev = class_device_get(class_dev);
	// there's no need to check class_dev here, as NULLs are detected
	// earlier, and class_device_get will crash rather than returning
	// a NULL for any other incorrect values.

Because in the first case if class_device_get succeeds, but class_id is empty,
the kobject will remain in a referenced state.

And one more thing. While preparing one more patch for submission, I realized
that the class_device_rename() function could be changed a little in order to
make it useable for setting the initial value of class_id field (I've seen
comments on drivers poking directly inside the class_device structure being a
Bad Thing):

int class_device_rename(struct class_device *class_dev, const char *new_name)
{
	char was_named = class_dev->class_id [0];

	if (was_named) {
		class_dev = class_device_get(class_dev);
		if (!class_dev)
			return -EINVAL;
		pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
			 new_name);
	}

	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);

	if (was_named) {
		kobject_rename(&class_dev->kobj, new_name);
		class_device_put(class_dev);
	}

	return 0;
}

I know patches are preferred, but our CVS is down right now and I don't have
an older copy of class.c.

And yet one more comment. What is the purpose of class_device_get at the
beginning and class_device_put at the end of the above function? I think if
someone calls class_device_rename, then it already holds a reference to the
class_device, so it can't go away while class_rename() is doing its work. And
if the caller *doesn't* hold a lock on it, it is simply wrong code since the
device may easily go away before class_rename() gets the lock.

--
Greetings,
   Andrew

P.S. Please Cc: replies to me as I'm not subscribed to this list.

P.P.S. Answering to Greg's Mar 02 2004 question about class_device_find
"Might I ask about which part of the kernel you are going to want to use this
call in?":

We (the people at handhelds.org) have implemented two subclasses for dealing
with LCD panels: the lcd class and the backlight class. The users of these
class objects (the framebuffer drivers) need some way to find the
corresponding backlight and lcd objects. We decided to give the backlight and
lcd objects the same name the framebuffer device has, e.g. framebuffer device
mq11xxfb0 uses lcd device mq11xxfb0 and backlight device mq11xxfb0. So the
class_device_find would do exactly what we need.
