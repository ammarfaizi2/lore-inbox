Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbULOWwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbULOWwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbULOWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:52:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:62916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262524AbULOWwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:52:24 -0500
Date: Wed, 15 Dec 2004 14:52:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
Message-ID: <20041215145222.V469@build.pdx.osdl.net>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Wed, Dec 15, 2004 at 02:00:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> The security_bprm_apply_creds() function is called from
> fs/exec.c:compute_creds() under task_lock(current).  SELinux must
> perform some work which is unsafe in that context, and therefore
> explicitly drops the task_lock, does the work, and re-acquires the
> task_lock.  This is unsafe if other security modules are stacked after
> SELinux, as their bprm_apply_creds assumes that the 'unsafe' variable is
> still meaningful, that is, that the task_lock has not been dropped.

I don't like this approach.  The whole point is to ensure safety, and
avoid races that have been found in the past.  This gives a new interface
that could be easily used under the wrong conditions, and breaking
the interface into two pieces looks kinda hackish.  Is there no other
solution?  I looked at this once before and wondered why task_unlock()
is needed to call avc_audit?  audit should be as lock friendly as printk
IMO, and I don't recall seeing any deadlock after short review of it.
But I didn't get much beyond that.  Is it all the flushing that can't
hold task_lock?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
