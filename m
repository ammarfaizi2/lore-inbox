Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWF3Kv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWF3Kv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWF3Kv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:51:59 -0400
Received: from javad.com ([216.122.176.236]:24842 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932308AbWF3Kv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:51:59 -0400
From: Sergei Organov <osv@javad.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org>
Date: Fri, 30 Jun 2006 14:51:33 +0400
In-Reply-To: <20060630001021.2b49d4bd.akpm@osdl.org> (Andrew Morton's
 message
	of "Fri, 30 Jun 2006 00:10:21 -0700")
Message-ID: <874py2apca.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> On Fri, 30 Jun 2006 01:48:02 -0400
> Andy Gay <andy@andynet.net> wrote:
[...]
>> +	if (tty && urb->actual_length) {
>> +		tty_buffer_request_room(tty, urb->actual_length);
>> +		tty_insert_flip_string(tty, data, urb->actual_length);
>
> Is it correct to ignore the return value from those two functions?

In fact, according to Alan Cox answer, the first call is useless here at
all, i.e., tty_buffer_request_room() is for subsequent
tty_insert_flip_char() calls in a loop, not for
tty_insert_flip_string(). tty_insert_flip_string() calls
tty_buffer_request_room() itself, and does it in a loop in attempt to
find as much memory as possible.

tty_insert_flip_string() returns number of bytes it has actually
inserted, but I don't believe one can do much if it returns less than
has been requested as it means that we are out of kernel memory.

Overall, it seems it should be just:

+	if (tty && urb->actual_length) {
+		tty_insert_flip_string(tty, data, urb->actual_length);

-- 
Sergei.
