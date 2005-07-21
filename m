Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVGURrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVGURrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 13:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGURrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 13:47:23 -0400
Received: from topconrd.ru ([62.105.138.7]:22676 "EHLO TopconRD.RU")
	by vger.kernel.org with ESMTP id S261809AbVGURrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 13:47:21 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux tty layer hackery: Heads up and RFC
References: <1121967993.19424.18.camel@localhost.localdomain>
X-attribution: osv
From: Sergei Organov <osv@topconrd.ru>
Date: 21 Jul 2005 21:47:11 +0400
In-Reply-To: <1121967993.19424.18.camel@localhost.localdomain>
Message-ID: <878y00831c.fsf@osv.topcon.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> At the moment tty buffers are attached directly to the tty. This is
> causing a lot of the problems related to tty layer locking, also
> problems at high speed and also with bursty data (such as occurs in
> virtualised environments)
> 
> I'm working on ripping out the flip buffers and replacing them with a
> pool of dynamically allocated buffers. This allows both for old style
> "byte I/O" devices and also helps virtualisation and smart devices where
> large blocks of data suddenely materialise and need storing.

Great! Really good news!

> 
> So far so good. Lots of drivers reference tty->flip.*. Several of them
> also call directly and unsafely into function pointers it provides. This
> will all break. Most drivers can use tty_insert_flip_char which can be
> kept as an API but others need more.
> 
> At the moment I've added the following interfaces, if people think more
> will be needed now is a good time to say
> 
> int tty_buffer_request_room(tty, size)
> 
> Try and ensure at least size bytes are available, returns actual room
> (may be zero). At the moment it just uses the flipbuf space but that
> will change. Repeated calls without characters being added are not
> cumulative. (ie if you call it with 1, 1, 1, and then 4 you'll have four
> characters of space. The other functions will also try and grow buffers
> in future but this will be a more efficient way when you know block
> sizes.
> 
> int tty_insert_flip_char(tty, ch, flag)
> 
> As before insert a character if there is room. Now returns 1 for
> success, 0 for failure.
> 
> int tty_insert_flip_string(tty, str, len)
> 
> Insert a block of non error characters. Returns the number inserted.
> 
> int tty_prepare_flip_string(tty, strptr, len)
> 
> Adjust the buffer to allow len characters to be added. Returns a buffer
> pointer in strptr and the length available. This allows for hardware
> that needs to use functions like insl or mencpy_fromio.

As you are going to replace flip buffers with different implementation
anyway, isn't it better to get rid of "flip" in the interface names as
well (maybe providing some synonyms for backward compatibility)? What I
mean is that names like

tty_buffer_insert_char()
tty_buffer_insert_string()

for the new interfaces would probably make more sense.

Otherwise I find the interfaces you suggest just fine and suitable for
the task I was unable to achieve without ugly hacks using current flip
buffers interfaces (reliable high-speed bulk USB tty driver).

-- 
Sergei.

