Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280659AbRKFWmS>; Tue, 6 Nov 2001 17:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280658AbRKFWmD>; Tue, 6 Nov 2001 17:42:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28167 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280653AbRKFWlw>; Tue, 6 Nov 2001 17:41:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Using %cr2 to reference "current"
Date: Tue, 6 Nov 2001 22:38:27 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9s9op3$2m3$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111061006150.2222-100000@penguin.transmeta.com> <E161B0f-0001Io-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1005086488 8979 127.0.0.1 (6 Nov 2001 22:41:28 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Nov 2001 22:41:28 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E161B0f-0001Io-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>> That should work fairly well, and has the advantage that you can hide more
>> state there if you want (ie it allows us, on demand, to move hot state of
>> "struct task_struct" up there).
>
>Sweet. Now that I'd completely missed. Task private state and task
>public state splitting

Yes. It would be a waste to have to bring in a cache-line into the L1
cache, and then only use 4 bytes of it. So it should make sense to set
this up somewhat like:

	struct local_task_struct {
		struct task_struct *tsk;
		.. other fields ..
	};

and then use the _exact_ existing infrastructure to get
"local_task_struct" instead of "task_struct", and let the compiler do
all the rest at a higher level. So we'd just rename "get_current()" to
"get_local_current()", and then do

	#define get_current()	(get_local_current()->tsk)

and people who want to know about the local task struct can use that.

		Linus
