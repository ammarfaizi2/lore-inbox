Return-Path: <linux-kernel-owner+w=401wt.eu-S1751908AbXARDmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbXARDmJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 22:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXARDmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 22:42:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39159 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbXARDmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 22:42:08 -0500
Date: Thu, 18 Jan 2007 09:11:53 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin Romer <benjamin.romer@unisys.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field (X86_64)
Message-ID: <20070118034153.GA5406@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com> <m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 12:08:48PM -0700, Eric W. Biederman wrote:
> Benjamin Romer <benjamin.romer@unisys.com> writes:
> 
> > On the Unisys ES7000/ONE system, we encountered a problem where
> > performing a kexec reboot or dump on any cell other than cell 0 causes
> > the system timer to stop working, resulting in a hang during timer
> > calibration in the new kernel.
> >
> > We traced the problem to one line of code in disable_IO_APIC(), which
> > needs to restore the timer's IO-APIC configuration before rebooting. The
> > code is currently using the 4-bit physical destination field, rather
> > than using the 8-bit logical destination field, and it cuts off the
> > upper 4 bits of the timer's APIC ID. If we change this to use the
> > logical destination field, the timer works and we can kexec on the upper
> > cells. This was tested on two different cells (0 and 2) in an ES7000/ONE
> > system.
> >
> > For reference, the relevant Intel xAPIC spec is kept at
> > ftp://download.intel.com/design/chipsets/e8501/datashts/30962001.pdf,
> > specifically on page 334.
> 
> Looks like good bug hunting.  I will have to look but it might
> make more sense to simply fix: struct IO_APIC_route_entry,
> or use whatever technique we normally use to generate the io_apic
> vectors.
> 
> I don't recall enough off of the top of my head to recall what
> the discrimination rule between logical and physical is but
> I think setting the system in physical mode is a good clue :)

Hi Eric,

In physical destination mode, the destination APIC is determined by 
APIC ID and in logical destination mode, destination apics are determined
by the configurations based on LDR and DFR registers in APIC (Depending
on Flat mode or cluster mode).

Looks like previously one supported only 4bit apic ids if system is
operating in physical mode and 8bit ids if IOAPIC is put in logical
destination mode. That's why, struct IO_APIC_route_entry is containing
4bits for physical apic id.

http://www.intel.com/design/chipsets/datashts/290566.htm

And now newer systems have switched to 8bit apic ids in physical mode.
That's why if somebody is crashing on a cpu whose apic id is more than
16, kexec/kdump code will fail as 4bits are not sufficient.

Hence above change makes sense. Given the fact that logical and physical
apic id is basically a union, it will work even for older systems where
physical apic ids were 4bits only.

OTOH, I think down the line we can get rid of physical dest
field all together in struct IO_APIC_route_entry and use logical dest
field.

Thanks
Vivek
