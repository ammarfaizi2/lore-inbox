Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbUKEQc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbUKEQc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUKEQc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:32:58 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18656 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262724AbUKEQcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:32:41 -0500
Date: Fri, 5 Nov 2004 10:32:38 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
Message-ID: <20041105163238.GA792@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <200411050723.iA57NGUv023856@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411050723.iA57NGUv023856@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One issue:  I'm seeing this from /usr/sbin/sendmail:
> 
> % /usr/sbin/sendmail
> drop_privileges: setuid(0) succeeded (when it should not)
> 
> I've not tracked down what's causing this indigestion yet (I suspect some
> bad interaction with capabilities - that's what caused that message to be
> added to Sendmail in the first place).

Chris had mentioned the stacker_capable not being quite right.  I'm
looking at it now, and yeah, it's a little convoluted.  I think a simpler

if (!stacked_modules) {
	/* same as before
}

final_result = 0;
for (m = stacked_modules; m; m = m->next) {
	result = (m->module_operations).capable(tsk,cap);
	if (result && !final_result) {
		final_result = result;
		if (short_circuit_capable)
			break;
	}
}
return final_result;

should be correct.

-serge
