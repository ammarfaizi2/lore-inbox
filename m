Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVIAGnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVIAGnD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVIAGnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:43:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24788 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932539AbVIAGnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:43:01 -0400
Date: Thu, 1 Sep 2005 07:43:13 +0100
From: viro@ZenIV.linux.org.uk
To: minyard@acm.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][CFLART] ipmi procfs bogosity
Message-ID: <20050901064313.GB26264@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/ipmi/ipmi_poweroff.c::proc_write_chassctrl()
	a) does sscanf on userland pointer
	b) does sscanf on array that is not guaranteed to have NUL in it
	c) interprets input in incredibly cretinous way:
if strings doesn't start with a decimal number => as if it was "0".
if it starts with decimal number equal to 0 (e.g. is "-0000splat") - as if
it was "0".
if it starts with decimal number equal to 2 (e.g. is "00002FOAD") - as if
it was "2".
otherwise - -EINVAL.
	In any case that doesn't end up with -EINVAL, pretend that entire
buffer had been written.

(a) and (b) are immediate bugs; (c) is a valid reason for immediate severe
LARTing of the pervert who had done _that_ in a user-visible API.

Note that API _is_ user-visible, so we can't blindly change it - not without
checking WTF do its users actually write to /proc/ipmi/poweroff_control.

Could somebody comment on the actual uses of that FPOS?  My preference would
be to remove the damn thing completely - it's too ugly to live.
