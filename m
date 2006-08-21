Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWHUDAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWHUDAh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWHUDAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:00:37 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:45964 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932529AbWHUDAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:00:37 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Date: Mon, 21 Aug 2006 03:00:22 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ecb7k6$grh$1@taverner.cs.berkeley.edu>
References: <20060819230532.GA16442@openwall.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1156129222 17265 128.32.168.222 (21 Aug 2006 03:00:22 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 21 Aug 2006 03:00:22 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solar Designer  wrote:
>The patch makes getsockopt(2) sanity-check the value pointed to by
>the optlen argument early on.  This is a security hardening measure
>intended to prevent exploitation of certain potential vulnerabilities in
>socket type specific getsockopt() code on UP systems.

This looks broken to me.  It has a TOCTTOU (time-of-check-to-time-of-use)
vulnerability (i.e., race condition): you read the length value twice,
and assume that you will get the same value both times.  That assumption
is not valid.

It looks like it will be easy to bypass this check.  For instance,
think about what happens if an adversary stores the length field in a
mmaped region, for instance.  It should be easy for the value of that
length field to change between when it was first read and when it was
subsequently read.  I don't see how this provides any "hardening" if
the attacker knows how to read kernel source code.  Am I missing
something?
