Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUFPUcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUFPUcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUFPUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:32:15 -0400
Received: from [208.245.16.50] ([208.245.16.50]:63567 "EHLO
	central.parcplace.com") by vger.kernel.org with ESMTP
	id S264727AbUFPUcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:32:14 -0400
Message-Id: <200406162032.NAA29397@central.parcplace.com>
From: eliot@cincom.com
Date: Wed, 16 Jun 2004 13:32:24 -0700
Subject: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches
To: linux-kernel@vger.kernel.org
cc: tgriggs@key.net, eliot@cincom.com
X-STAMP-Fonts-Run: 1936 1 
MIME-Version: 1.0 (STAMPed mail)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I am the team lead and chief VM developer for a Smaltalk implementation based on a JIT execution engine.  Our customers have been seeing rare incorrect floating-point results in intensive fp applications on 2.6 kernels using various x86 compatible processors.  These problems do not occur on previous kernel versons.  We recently had occasion to reimplement our fp primitives to avoid severe performance problems on Xeon processors that were traced to Xeon's relatively slow implementation of fnclex and fstsw.  The older implementaton would produce a result and test for a valid (non NaN, non Inf) result by examining the FPU status flags via fstsw.  The newer implementation produces a result and tests its exponent for the NaN/Inf exponent.  The new implementation does not show the rare incorrect floating-point results in intensive fp applications on 2.6 kernels.  My conclusion is that context switches between the production of the result and the execution of the fstsw are the culprit, and that the context switch machinery fails to preserve the FPU status flags.

I don't know whether any action on your part is appropriate.  The use of the FPU status flags is presumably rare on linux (I believe that neither gcc nor glibc make use of them).  But "exotic" execution machinery such as runtimes for dynamic or functional languages (language implementations that may not use IEEE arithmetic and instead flag Infs and NaNs as an error) may fall foul of this issue.  Since previous versions of the kernel on x86 apparently do preserve the FPU status flags perhaps its simple to preserve the old behaviour.  At the very least let me suggest you document the limitation.

Sincerely,
---
Eliot Miranda                 ,,,^..^,,,                mailto:eliot@cincom.com
VisualWorks Engineering, Cincom  Smalltalk: scene not herd  Tel +1 408 216 4581
3350 Scott Blvd, Bldg 36 Suite B, Santa Clara, CA 95054 USA Fax +1 408 216 4500


