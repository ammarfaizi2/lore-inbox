Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTEFVe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTEFVe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:34:27 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:9619 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261965AbTEFVeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:34:25 -0400
Date: Tue, 6 May 2003 17:44:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200305061746_MC3-1-37B4-7931@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > It seems the heuristic is more complicated
> 
> Any suggestions?


 Does this pseudocode look like it would work?  It should make it
only complain if two or more interrupts in a row go unhandled.

   
int last_irq_was_dropped[NR_IRQS];

/* call each handler in turn for this irq */

for (each_driver(irq)) {
        ret = call_driver();
        if (ret == irq_handled) {
                if (unlikely(last_irq_was_dropped[irq])
                        last_irq_was_dropped[irq] = 0;
                break;
        }
}
if (ret != irq_handled) {
        if (unlikely(last_irq_was_dropped[irq]))
                complain();
        else
                last_irq_was_dropped[irq] = 1;
}
