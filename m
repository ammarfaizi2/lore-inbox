Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWGJI2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWGJI2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWGJI2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:28:06 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:39731 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751365AbWGJI2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:28:02 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
cc: vgoyal@in.ibm.com, akpm@osdl.org, James.Bottomley@steeleye.com,
       "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id 
In-reply-to: Your message of "Mon, 10 Jul 2006 16:50:52 +0900."
             <1152517852.2120.107.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jul 2006 18:27:48 +1000
Message-ID: <5742.1152520068@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao (on Mon, 10 Jul 2006 16:50:52 +0900) wrote:
>On the event of a stack overflow critical data that usually resides at
>the bottom of the stack is likely to be stomped and, consequently, its
>use should be avoided.
>
>In particular, in the i386 and IA64 architectures the macro
>smp_processor_id ultimately makes use of the "cpu" member of struct
>thread_info which resides at the bottom of the stack. x86_64, on the
>other hand, is not affected by this problem because it benefits from
>the use of the PDA infrastructure.
>
>To circumvent this problem I suggest implementing
>"safe_smp_processor_id()" (it already exists in x86_64) for i386 and
>IA64 and use it as a replacement for smp_processor_id in the reboot path
>to the dump capture kernel. This is a possible implementation for i386.

I agree with avoiding the use of thread_info when the stack might be
corrupt.  However your patch results in reading apic data and scanning
NR_CPU sized tables for each IPI that is sent, which will slow down the
sending of all IPIs, not just dump.  It would be far cheaper to define
a per-cpu variable containing the logical cpu number, set that variable
once as each cpu is brought up and just read it in cases where you
might not trust the integrity of struct thread_info.  safe_smp_processor_id()
resolves to just a read of the per cpu variable.

