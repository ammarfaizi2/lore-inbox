Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbULOUjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbULOUjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbULOUjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:39:41 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:42905 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262418AbULOUjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:39:40 -0500
Subject: Re: [PATCH] Properly split capset_check+capset_set
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1103142857.32732.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 15:34:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 14:48, Serge E. Hallyn wrote:
> The attached patch (against 2.6.10-rc3-mm1 w/ ioctl patch) removes the
> redundant cap_capset_check hook and moves the security_capset_check
> call to just before security_capset_set.  The selinux_capset_set hook
> now simply sets the capability (through its secondary), while
> selinux_capset_check checks the authorization permission.

One minor complaint:  the caller of capset() will no longer receive any
error code if security_capset_check() fails.  I don't think that it is
necessary to preserve any error return in the cases where capset() is
being applied to multiple processes, but in the case where it is being
applied to a single specific process, it would be nice if any error
return from security_capset_check() would be returned to the caller.

I also wonder whether the existing hardcoded checks should be moved into
the new security_capset_check() hook function for dummy and commoncap so
that they will be applied to the real target, even when pid < 0. 
Otherwise, those hardcoded checks seem bogus in the pid < 0 case, as
they are then applied to current rather than to the true targets.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

