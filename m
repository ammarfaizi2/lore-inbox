Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWHJLwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWHJLwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWHJLwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:52:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51607 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161185AbWHJLwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:52:18 -0400
From: Andi Kleen <ak@suse.de>
To: Fernando Luis =?iso-8859-15?q?V=E1zquez_Cao?= 
	<fernando@oss.ntt.co.jp>
Subject: Re: [PATCH 1/2] i386: Disallow kprobes on NMI handlers - try #2
Date: Thu, 10 Aug 2006 13:52:08 +0200
User-Agent: KMail/1.9.3
Cc: prasanna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
References: <1155209773.4141.10.camel@localhost.localdomain>
In-Reply-To: <1155209773.4141.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200608101352.08828.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 13:36, Fernando Luis Vázquez Cao wrote:
> A kprobe executes IRET early and that could cause NMI recursion and stack
> corruption.
> 
> Note: This problem was originally spotted and solved by Andi Kleen in the
> x86_64 architecture. This patch is an adaption of his patch for i386.

Originally Jan Beulich discovered these classes of bugs actually

I applied the two patches (after fixing lots of rejects because that
code had already changed a lot). But I have my doubts it is complete.

e.g. the NMI watchdog nmi code has lots of callees which you don't
handle (notifier chains, spinlocks, printks which can call practically everything, ...) 

The printk in the NMI handler look pretty bogus so I just removed it.

But all the other code would be tricky. but .e.g. marking up 
spinlocks would be probably not a good idea. 

When we oops (call die) perhaps we can force kprobes to be disabled? 

Also everybody hooking into the die chain would need to be covered too.

Probably some followon work is needed.

-Andi
