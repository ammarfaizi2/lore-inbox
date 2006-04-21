Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWDUEW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWDUEW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWDUEW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:22:27 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:36495 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932187AbWDUEW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:22:26 -0400
Subject: Removing .tmp_versions considered harmful
From: Pavel Roskin <proski@gnu.org>
To: Sam Ravnborg <sam@mars.ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Apr 2006 00:22:22 -0400
Message-Id: <1145593342.2904.30.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A patch applied shortly after Linux 2.6.16
(fb3cbd2e575f9ac0700bfa1e7cb9f4119fbd0abd in git) causes
the .tmp_versions directory to be removed every time make is run to
build external modules.

This is bad for two reasons.

1) When "make install" is run as root, .tmp_versions is re-created and
becomes owned by root.  Subsequent "make" by user fails
because .tmp_versions cannot be removed.

2) The projects where modules are build in more than one directory (such
as MadWifi) are now compiled with spurious warnings about unresolved
symbols.  This happens because every module is compiled individually,
and the *.mod files for one module are removed before the other is
compiled.

In both cases, I cannot think of any sane workarounds.  For the first
problem, MODVERDIR could be set to different values for different
usernames.  For the second problem, I considered clever ways to sabotage
some targets based on the target name, something like:

divert_crmodverdir = some_other_dir
MODVERDIR=$(SYMBOLSDIR)'$$(divert_$$@)'

When I looked on this the next day I realized that it's ugly as hell.
Why should I invent workarounds for what should be a standard situation?

Since I don't see any better approach, I'm asking the commit
fb3cbd2e575f9ac0700bfa1e7cb9f4119fbd0abd to be reverted for Linux
2.6.17.  The problem it solves (stale *.mod files) is not nearly as big
as the problems it creates.

Note that the removal on *.mod files only would not address the MadWifi
problem.

-- 
Regards,
Pavel Roskin

