Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUCJByg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 20:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUCJByg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 20:54:36 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:5821 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261920AbUCJByd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 20:54:33 -0500
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: corliss@digitalmages.com, riel@redhat.com, tim@physik3.uni-rostock.de,
       jerj@coplanar.net
Content-Type: text/plain
Organization: 
Message-Id: <1078883951.2232.501.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Mar 2004 20:59:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We might, however, put the magic into the implicit padding
> of ac_flag (ugly, since this would require an arch dependant
> definition of stuct acct), or put it into the uppermost
> three bits of ac_flag itself

First of all, none of this matters much if the format
is given a sysctl. The old format is default for now,
and the new one is default (only?) in a couple years.
Sun appears to have done something like this.

When fixing it, note that a 5-bit binary exponent
with denormals would beat the current float format.

Regarding the existing struct though...

Let's take a close look at this. I think there are 2 bytes
of padding on all Linux ports, and another 2 available
on everything except maybe m68k and/or arm. (that is, ports
that will put a u32 on any u16 boundry) Here is the current
struct, compactly formatted with 64-bit blocking:

struct linux_acct {
        char   ac_flag;        // Flags
// 1 pad byte
        __u16  ac_uid;         // Real User ID    
        __u16  ac_gid;         // Real Group ID      
        __u16  ac_tty;         // Control Terminal

        __u32  ac_btime;       // Process Creation Time
        comp_t ac_utime;       // User Time     
        comp_t ac_stime;       // System Time

        comp_t ac_etime;       // Elapsed Time
        comp_t ac_mem;         // Average Memory Usage
        comp_t ac_io;          // Chars Transferred
        comp_t ac_rw;          // Blocks Read or Written

        comp_t ac_minflt;      // Minor Pagefaults   
        comp_t ac_majflt;      // Major Pagefaults  
        comp_t ac_swaps;       // Number of Swaps
// 2 pad bytes (except m68k or arm maybe?)

        __u32  ac_exitcode;    // Exitcode
// hppa might pad this
        char   ac_comm[17];    // Command Name    
// hppa might pad this
        char   ac_pad[10];     // Padding Bytes
// 1 pad byte (maybe 6 for hppa)
};

Just a sec... ARRRGH WHY DO PEOPLE LEAVE PADDING AND
GENERALLY MIS-ALIGN THINGS ALL THE TIME??????

So there you go. You have a pad byte after ac_flag
at a known location, and a pad byte after ac_pad that
might move a bit due to mis-alignments above it.


