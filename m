Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbULHB43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbULHB43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULHB43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:56:29 -0500
Received: from www.zeroc.com ([63.251.146.250]:34227 "EHLO www.zeroc.com")
	by vger.kernel.org with ESMTP id S261995AbULHB4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:56:23 -0500
Message-ID: <079001c4dcc9$1bec3a60$6401a8c0@centrino>
From: "Bernard Normier" <bernard@zeroc.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org>
Subject: Re: Concurrent access to /dev/urandom
Date: Tue, 7 Dec 2004 20:56:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In which version of 2.6 did this bug get fixed? I am seeing these duplicates 
with 2.6.9-1.667smp (FC3)?
I am just trying to generate UUIDs (without duplicates, obviously).

Thanks,
Bernard

> On Tue, Dec 07, 2004 at 06:41:12PM -0500, Bernard Normier wrote:
>> Reading concurrently /proc/sys/kernel/random/uuid also returns duplicates
>> quite quickly ... which definitely looks like a bug. I included a small
>> python test-case below.
>> Can anybody suggest a work-around, for example a simple way to serialize
>> access to /dev/urandom from multiple threads/processes on the same box?
>
> This has been fixed in 2.6, but not yet in 2.4.  Really, this should
> be fixed in the kernel, but if you need to worry about this from the
> perspective of user-level programs that might be running on unfixed
> distribution kernels, the best way to deal with the problem is to use
> /dev/urandom to seed a cryptographic random number generator, and then
> mix in your pid and time/date into the CRNG.
>
> For example (in Pseudo code):
>
> char key[16];
> int  counter;
>
> seed_random_number_generator()
> {
> key <- SHA(20 bytes from /dev/random || pid || time(0));
> counter = 0;
> }
>
> get_random_bytes()
> {
> return SHA(counter++ || key);
> }
>
> This by the way is a generally a good thing to do in all cases;
> /dev/urandom is designed to be used to seed a cryptographic random
> generator.  If you need a large number of cryptographic random
> numbers, it's much faster to do it in user space than to try to do it
> in the kernel.
>
> - Ted
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

