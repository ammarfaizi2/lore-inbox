Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbULPNDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbULPNDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbULPNDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:03:14 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:53444 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262665AbULPMxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:53:17 -0500
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215145222.V469@build.pdx.osdl.net>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <20041215145222.V469@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1103201275.1463.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 07:47:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 17:52, Chris Wright wrote:
> I don't like this approach.  The whole point is to ensure safety, and
> avoid races that have been found in the past.  This gives a new interface
> that could be easily used under the wrong conditions, and breaking
> the interface into two pieces looks kinda hackish.  Is there no other
> solution?  I looked at this once before and wondered why task_unlock()
> is needed to call avc_audit?  audit should be as lock friendly as printk
> IMO, and I don't recall seeing any deadlock after short review of it.
> But I didn't get much beyond that.  Is it all the flushing that can't
> hold task_lock?

avc_audit() used to always call get_task_mm() when fetching the mm for
use in determining the executable, which was producing deadlock when the
caller held task lock.  However, I changed it to only use get_task_mm
when acting on a task other than current, since we can safely access
current->mm, which eliminated the deadlock for the checks in
bprm_apply_creds.  That is why Serge's patch folds
avc_has_perm_noaudit()+avc_audit() pairs down to avc_has_perm() and
keeps them in bprm_apply_creds.  Hence, avc_audit is no longer a
concern.

The concern is with lock nesting for the flushing code, e.g. call to
force_sig_specific and signal inheritance flush would nest siglock under
task lock and call to flush_unauthorized_files would nest file_list_lock
and file_lock under task lock.  That code didn't used to be called under
task lock prior to the reworking of compute_creds by Andy Lutomirski,
and when compute_creds was overhauled, there was some concern expressed
by Andrew Morton about the lock nesting, iirc.

Note that the flushing code isn't relying on the safety flags computed
earlier by unsafe_exec, so it really doesn't need the task lock for that
purpose.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

