Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUC0Ejk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 23:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUC0Ejk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 23:39:40 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:32432 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261667AbUC0Ejh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 23:39:37 -0500
Message-ID: <048e01c413b3$3c3cae60$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Kernel support for peer-to-peer protection models...
Date: Fri, 26 Mar 2004 20:23:14 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're a processor startup with a new architecture that we will be porting
Linux to. The bulk of the port will be straightforward (well, you know what
I mean), except for the protection model supported by the hardware.  How
would you extend/mod the kernel if you had hardware that:

1) had a large number of distinguishable address spaces
2) any running code had two of these (code and data environment) it could
use arbitrarily, but access to addresses in others was arbitrarily protected
3) flat, unified virtual addresses (64 bit) so that pointers, including
inter-space pointers, have the same representation in all spaces
4) no "supervisor mode"
5) inter-space references require grant of access (transitive) by the
accessed space; grants can be entire space or any contiguous subspace
6) inter-space reference has same performance as intra-space
7) you can call across space boundaries in a way that changes the governing
space and consequently the protection environment. Thus both code and data
of a server process or DLL may be non-addressable by an app process, but the
app can call a function (controllably) in the server/DLL and that function
will run in the protection environment of the server/DLL, not that of the
app, though it will run in the app's stack (in the app's address space) with
no task switch. Return unwinds the change. This with full protection both
ways - neither the app nor the server/DLL can klobber each other.
Performance is the same as a conventional intra-space call/return.
8) OS calls are not traps, just inter-space calls, again with full
protection.
9) Hardware interrupts are involuntary inter-space calls. They do not
require locking (assuming the handler is re-entrant - and if not then only
from themselves), nor task switch, nor disabling other interrupts. The
handler runs in the stack of whoever got interrupted, which (depending on
interrupt priorities) could be another interrupt, on an interrupt, ... on an
app, all mutually protected.
10) Drivers can have their own individual space(s) distinct from those of
the kernel and the apps. Buggy drivers cannot crash the kernel.


We could of course ignore the hardware model and emulate a conventional
processor (and might, as a first step of the port), but this would discard
significant reliability/performance improvements that the hardware could
provide.

Is this model so alien to the existing Kernel that the best approach is to
peel off a kernel tarball and create a new kernel, to be maintained in
isolation forever? Or would this work fit into planned/expected kernel work
dealing with protection models, interrupts, trap handling and the like? What
about partitioning the kernel into disjoint (and mutually protected)
components like IP stack, password/security, FS etc?

We will not be beginning this port for six months or so - the compiler has
to come up first :-)  So this question is more to get some sense of the lay
of the land rather than any immediate help. We know that there is a lot of
know-how and strong opinions concentrated in the kernel development crew,
and we want to gain from that and also to contribute what is currently
budgeted as some 10 engineer-years of work upcoming to the general
improvement if it can be done. Alternatively we might be too wierd to be
worth bothering with for the group, and so we should do it on our own and
not try to fit with the "Linux way of doing things".

Comments please?

Ivan


