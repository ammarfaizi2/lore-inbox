Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTK1Pyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 10:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTK1Pyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 10:54:51 -0500
Received: from gprs148-17.eurotel.cz ([160.218.148.17]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262446AbTK1Pyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 10:54:49 -0500
Date: Fri, 28 Nov 2003 16:37:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: insunficient locking in input.c (?)
Message-ID: <20031128153727.GA194@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems to me some more locking is needed:

1) input_event() seems to be called from both keyboard interupt and
from timer. That makes it pretty nasty beast.

It does:

...
                list_for_each_entry(handle, &dev->h_list, d_node)
                        if (handle->open)
                                handle->handler->event(handle, type, code, value);
...

while input_unregister_handler could be running (on other CPU?)

void input_unregister_handler(struct input_handler *handler)
{
        struct list_head * node, * next;

        list_for_each_safe(node, next, &handler->h_list) {
                struct input_handle * handle = to_handle_h(node);
                list_del_init(&handle->h_node);
                list_del_init(&handle->d_node);
                handler->disconnect(handle);
        }

I guess that some locking around these lists is needed.

2) input_event() is called from both keyboard interupt and from
timer. That makes it behave pretty badly w.r.t. low-level handlers. I
think that you can have one low-level handler running two times
concurrently.

There's no locking preventing that. AFAICS autorepeat timer can tick
once more after key is released, which is normally not a problem, but
if key is pressed while that, it looks to me like there can be normal
key down and autorepeat entering input_event() concurrently, which
then calls low-level handler (for example kbd_keycode)
concurrently. kbd_keycode() certainly is not written to handle _that_.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
