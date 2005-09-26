Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbVIZOgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbVIZOgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbVIZOgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:36:23 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:21491 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751635AbVIZOgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:36:23 -0400
Subject: Re: security/selinux/hooks.c:flush_unauthorized_files()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Wright <chrisw@osdl.org>, jmorris@namei.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050926125522.GA25687@lst.de>
References: <20050926125522.GA25687@lst.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 26 Sep 2005 10:32:59 -0400
Message-Id: <1127745179.19016.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 14:55 +0200, Christoph Hellwig wrote:
> Folks, what is this code doing in a security module?
> 
> The check for unauthorized files should really move into
> flush_old_files, removing the horrible devnull hack at the same time.

Not objecting to moving it into core code, but a couple of concerns
about the details:
- Doing it in flush_old_files will require propagating the brpm down so
that we can extract the new task credentials from it for use in the
checks (current checks can use the current task credentials since it
occurs after the new credentials are applied, which depends on the prior
checks for shared state to avoid the obvious potential leak),
- Associating the descriptors closed by policy denials with devnull is
important to avoid application misbehavior; that logic was specifically
added to address real breakage in applications.  We really don't want to
remove that logic.  It currently uses a devnull node from selinuxfs at
Viro's suggestion, so it is currently SELinux-dependent.

> The tty loop isn't in the right place either, and it seems we might
> be missing a call to disassociate_tty if the current process is the
> session leader.  I'd suggest moving this code into fs/exec.c aswell,
> aksing the security module for the actual permissions through an LSM
> hook.

What would you suggest as a better place for rechecking access to the
controlling tty?  As above, we could move it to flush_old_files, but
would need to extract the new task credentials from the bprm for the
check.

-- 
Stephen Smalley
National Security Agency

