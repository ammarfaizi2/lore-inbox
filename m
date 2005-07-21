Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVGURWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVGURWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 13:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGURWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 13:22:11 -0400
Received: from [81.2.110.250] ([81.2.110.250]:31978 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261803AbVGURWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 13:22:10 -0400
Subject: Linux tty layer hackery: Heads up and RFC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Jul 2005 18:46:32 +0100
Message-Id: <1121967993.19424.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment tty buffers are attached directly to the tty. This is
causing a lot of the problems related to tty layer locking, also
problems at high speed and also with bursty data (such as occurs in
virtualised environments)

I'm working on ripping out the flip buffers and replacing them with a
pool of dynamically allocated buffers. This allows both for old style
"byte I/O" devices and also helps virtualisation and smart devices where
large blocks of data suddenely materialise and need storing.

So far so good. Lots of drivers reference tty->flip.*. Several of them
also call directly and unsafely into function pointers it provides. This
will all break. Most drivers can use tty_insert_flip_char which can be
kept as an API but others need more.

At the moment I've added the following interfaces, if people think more
will be needed now is a good time to say


int tty_buffer_request_room(tty, size)

Try and ensure at least size bytes are available, returns actual room
(may be zero). At the moment it just uses the flipbuf space but that
will change. Repeated calls without characters being added are not
cumulative. (ie if you call it with 1, 1, 1, and then 4 you'll have four
characters of space. The other functions will also try and grow buffers
in future but this will be a more efficient way when you know block
sizes.

int tty_insert_flip_char(tty, ch, flag)

As before insert a character if there is room. Now returns 1 for
success, 0 for failure.

int tty_insert_flip_string(tty, str, len)

Insert a block of non error characters. Returns the number inserted.

int tty_prepare_flip_string(tty, strptr, len)

Adjust the buffer to allow len characters to be added. Returns a buffer
pointer in strptr and the length available. This allows for hardware
that needs to use functions like insl or mencpy_fromio.


I've converted a fair number of drivers to this API ready and I'll post
some patches for review soon.

Alan

