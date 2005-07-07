Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVGGWAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVGGWAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGGV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:58:41 -0400
Received: from mail.riseup.net ([69.90.134.155]:28074 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S261539AbVGGV4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:56:39 -0400
Date: Thu, 7 Jul 2005 23:59:28 +0200
From: st3@riseup.net
To: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Cc: cpufreq@lists.linux.org.uk
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050707235928.71016f61@horst.morte.male>
In-Reply-To: <42CC37FD.5040708@tmr.com>
References: <20050706112202.33d63d4d@horst.morte.male>
	<42CC37FD.5040708@tmr.com>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 15:58:53 -0400
Bill Davidsen <davidsen@tmr.com> wrote:

> st3@riseup.net wrote:

[snip]

> > Moreover, I checked on Pentium M 725 and Pentium M 715 that the lowest
> > frequency at which the CPU can be set safely is not the 600MHz given in
> > datasheets, but 400MHz instead, with VID#A, VID#B, VID#C and VID#D (see
> > datasheet for more details) set to 0.908V.
> > 
> > I can provide a patch, let me know.
> 
> Slower is better

[snip]

Here's a quick trick for getting CPU to lower frequencies than the ones
read from ACPI tables, while still keeping them available.

Just add these lines in centrino_cpu_init_acpi(), in speedstep-centrino.c,
just after (and outside) the first 'for' cycle like this:
for (i=0; i<p.state_count; i++) { ...

centrino_model[cpu]->op_points[p.state_count - 1].index = 0x040D;
centrino_model[cpu]->op_points[p.state_count - 1].frequency = 400000;
p.states[p.state_count - 1].core_frequency = 400;

This will enable 400MHz at 908mV, which I found to be useful on Dothan
CPUs. If you want to get values for other frequencies/voltages, just use
something like:

#include <stdio.h>

int main() {
unsigned int index, frequency, voltage

index = (((frequency)/100) << 8) | ((voltage - 700) / 16);
printf ("%u\n", index);
}

frequency is expressed in MHz, voltage in mV, index is the value for
centrino_model[cpu]->op_points[y].index <- remember to change this y if you
want to add multiple frequencies besides the ACPI ones; for example, if you
want 500MHz at 940mV, you could add:

centrino_model[cpu]->op_points[p.state_count - 2].index = 0x1295;
centrino_model[cpu]->op_points[p.state_count - 2].index = 500000;
p.states[p.state_count - 2].core_frequency = 500;

Sorry if I have been off-topic.


--
ciao
st3

