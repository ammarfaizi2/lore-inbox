Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSANCkP>; Sun, 13 Jan 2002 21:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288696AbSANCkB>; Sun, 13 Jan 2002 21:40:01 -0500
Received: from mnh-1-17.mv.com ([207.22.10.49]:39947 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288689AbSANCjb>;
	Sun, 13 Jan 2002 21:39:31 -0500
Message-Id: <200201140239.VAA05307@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org
Subject: The O(1) scheduler breaks UML
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Jan 2002 21:39:45 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new scheduler holds IRQs off across the call to context_switch.  UML's
_switch_to expects them to be enabled when it is called, and things go
badly wrong when they are not.

Because UML has a host process for each UML thread, SIGIO needs to be 
forwarded from one process to the next during a context switch.  A SIGIO 
arriving during the window between the disabling of IRQs and forwarding of 
IRQs to the next process will be trapped on the process going out of
context.  This happens fairly regularly and causes hangs because some process
is waiting for disk IO which never arrives because the process that was notified
of the completion is switched out.

So, is it possible to enable IRQs across the call to _switch_to?

				Jeff

