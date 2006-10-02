Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWJBJY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWJBJY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWJBJY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:24:28 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:24024 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751020AbWJBJY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:24:28 -0400
Subject: debugfs oddity
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <gregkh@suse.de>, Takashi Iwai <tiwai@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>, Michael Buesch <mb@bu3sch.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 11:25:04 +0200
Message-Id: <1159781104.2655.47.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I observed (in bcm43xx) that debugfs seems to keep things
alive when userspace still has a directory open. Consider the following
sequence of events:
 (a) kernel code creates a directory in debugfs
 (b) user changes current directory to that
 (c) kernel code removes that directory in debugfs

Now, consider the equivalent sequence in a regular filesystem (or
tmpfs):
 (a') user creates directory
 (b') user cd's into it
 (c') user deletes directory from a different shell

The same thing should happen, in both cases the directory is kept around
in a way until the process that has the current dir in the dead
directory gives it up.

Now, however, consider
 (d') user creates directory with the same name

This works fine, and the old process sees nothing that happens in the
new directory, as expected. However,
 (d) kernel code tries to create a debugfs directory with the same name

does not work at all.

Is this expected behaviour? It seems that once a driver requested that a
directory is removed it can rightfully expect to be able to recreate it
afterwards even if there's still the need to keep it lingering around
for a bit.

Similar things can probably happen when attributes are kept open, but I
haven't tested this. I have also not tested sysfs or configfs.

johannes
