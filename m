Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTFKErn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTFKErn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:47:43 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:1525 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S262363AbTFKErm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:47:42 -0400
Message-ID: <3EE6B7A2.3000606@austin.rr.com>
Date: Wed, 11 Jun 2003 00:01:22 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compiling kernel with SuSE 8.2/gcc 3.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

> during tests with latest SuSE distro 8.2 compiling 2.4.21-pre6 showed a lot of
> "comparison between signed and unsigned" warnings. It looks like SuSE ships gcc

I also noticed lots of compiler warnings with gcc 3.3, now default in SuSE, 
and cleaned up most of them for the cifs vfs but there are a few that just
look wrong for gcc to spit out warnings on.   For example the following
local variable definition and the similar ones in the same file
(fs/cifs/inode.c):

	__u64 uid = 0xFFFFFFFFFFFFFFFF;

generates a warning saying the value is too long for a long on 
x86 SuSE 8.2 with gcc 3.3 - which makes no sense.  Any value
above 0xFFFFFFFFF generates the same warning (intuitively
36 bits should fit in an unsigned 64 bit local variable).

Defining the literal with the UL suffix didn't seem to help - and I 
rebelled against the solutions that work for this case ie casting 
the local variable which is already __u64 to __u64 but that 
presumably would work for those three, as would a (__u64)cast 
of -1 which seems equally ugly).  Unfortunately for the CIFS
Unix Extensions these values really are supposed to be 64 bit
on the wire (0xFFFFFFFFFFFFFFFF indicating ignore setting this value).
In the current version of the cifs vfs (http://cifs.bkbits.net/linux-2.5cifs)
the only other case that now generates compiler warnings (in this case
signed/unsigned compares) is the comparison of unsigned local variables
to the literal PAGE_CACHE_SIZE (which presumably is interpreted as 
signed by the compiler).

Any idea what is going on in this weird gcc 3.3 behavior where it thinks
64 bits can't fit in a __u64 local variable? 


