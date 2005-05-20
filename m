Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVETPTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVETPTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVETPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:19:35 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:14529 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261470AbVETPSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:18:50 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116601195.29037.18.camel@localhost.localdomain>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 May 2005 11:09:17 -0400
Message-Id: <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 15:59 +0100, David Woodhouse wrote:
> On Fri, 2005-05-20 at 10:30 -0400, Valdis.Kletnieks@vt.edu wrote:
> > Looks like we either only swatted half the bug, or the patch moved it
> > around. Slightly different trace this time:
> 
> OK. Steve's audit_log_d_path() change, which I pulled in because it had
> the side-effect of NUL-terminating the buffer, is now using GFP_KERNEL
> where previously it was not. 
> 
> We could make it use GFP_ATOMIC, but I suspect the better answer if at
> all possible would be to make sure that avc_audit doesn't call it with
> spinlocks held. Or maybe to make avc_audit() pass a gfp_mask to it, but
> I don't like that much.

The lock is being held by the af_unix code (unix_state_wlock), not
avc_audit; the AVC is called under all kinds of circumstances (softirq,
hard irq, caller holding locks on relevant objects) for permission
checking and must never sleep.

One option might be to defer some of the AVC auditing to the audit
framework (e.g. save the vfsmount and dentry on the current audit
context and let audit_log_exit perform the audit_log_d_path).

-- 
Stephen Smalley
National Security Agency

