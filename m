Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSAVLLE>; Tue, 22 Jan 2002 06:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289273AbSAVLKy>; Tue, 22 Jan 2002 06:10:54 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:10500 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289270AbSAVLKq>;
	Tue, 22 Jan 2002 06:10:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Armin Schindler <mac@melware.de>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, kkeil@suse.de,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: missing memset in divas and eicon in 2.2.20 
In-Reply-To: Your message of "Tue, 22 Jan 2002 10:19:15 BST."
             <Pine.LNX.4.31.0201221017280.21391-100000@phoenix.one.melware.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Jan 2002 21:43:15 +1100
Message-ID: <15377.1011696195@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002 10:19:15 +0100 (MET), 
Armin Schindler <mac@melware.de> wrote:
>Did you use plain 2.2.20 ?
>I cannot reproduce this problem here, can you please send me your
>kernel config.
>
>On Tue, 22 Jan 2002, Peter T. Breuer wrote:
>>   betty:/usr/local/src/linux-2.2.20% sudo depmod -ae -F System.map 2.2.20-SMP
>>   depmod: *** Unresolved symbols in
>>   /lib/modules/2.2.20-SMP/misc/divas.o depmod:         memset
>>   depmod: *** Unresolved symbols in
>>   /lib/modules/2.2.20-SMP/misc/eicon.o depmod:         memset

This can be a gcc problem.  Some versions of gcc generate internal
calls to memset and memcpy when manipulating structures.  Because these
internal calls are created after cpp they end up as phantom calls to
functions instead of being converted by string.h.

If it is a gcc problem, you track it down by first identifying the object

  nm -A drivers/isdn/eicon/*.o | fgrep memset

then compile the xxx object with -S

  make CFLAGS_xxx.o=-S SUBDIRS=drivers/isdn/eicon modules

vi drivers/isdn/eicon/xxx.o looking for calls to memset.  Scroll up
until you find the function that that is generating the call, then
eyeball the code looking for structure assignments like s = *foo or s =
0.  Replace the assignments with explicit calls to memcpy or memset.

