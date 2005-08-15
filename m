Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVHORMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVHORMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVHORMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:12:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51600 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964848AbVHORML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:12:11 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Mon, 15 Aug 2005 10:11:47 -0700
User-Agent: KMail/1.7.1
Cc: "Andi Kleen" <ak@suse.de>, "Russ Weight" <rweight@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CBB@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CBB@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151011.47290.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 August 2005 09:35 pm, Protasevich, Natalie wrote:
> > On Thursday 04 August 2005 02:22 am, Andi Kleen wrote:
> > > On Thu, Aug 04, 2005 at 12:05:50AM -0700, James Cleverdon wrote:
[ Snip! ]
> > >
> > > Can we perhaps force such sharing early temporarily even when the 
> > > table is not filled up?  This way we would get better test 
> > coverage of 
> > > all of  this.
> > >
> > > That would be later disabled of course.
> > 
> > Suppose I added a static counter and pretended that every 
> > third non-legacy IRQ needed to be shared?
> > 
> > > Rest looks ok to me.
> > >
> > > -Andi
> > 
> > Sigh.  Have to attach the file again.  Sorry about that.
> > 
> > Signed-off-by:  James Cleverdon <jamesclv@us.ibm.com>
> 
> I think you were going to change this line, which fixed the jumps in the
> irq distribution:
>

Actually, no.  That line fixed the jumps but didn't keep irq_vector[]
values from being splattered in a corner case.  The use of
__assign_irq_vector() should fix that entirely.

Corner case:  GSIs aren't always presented in monotonic order (or at
least, we shouldn't depend on it).  Suppose we had already allocated
IRQ 16 when GSI 16 came along.  The call to assign_irq_vector() would
have the side effect of overwriting irq_vector[16], even though we
would ultimately assign IRQ 17 to the GSI.

Better to not change any global state using __assign_irq_vector until
we're sure which IRQ will be used.


> --- io_apic.c	2005-08-11 10:14:33.564748923 -0700
> +++ io_apic.c.new	2005-08-11 10:15:55.412331115 -0700
> @@ -617,7 +617,7 @@ int gsi_irq_sharing(int gsi)
>   	 * than PCI.
>   	 */
>   	for (i = 0; i < NR_IRQS; i++)
>  -		if (IO_APIC_VECTOR(i) == vector) {
>  +		if (IO_APIC_VECTOR(i) == vector && i != gsi) {
>   			if (!platform_legacy_irq(i))
>   				break;			/* got one */
>   			IO_APIC_VECTOR(gsi) = 0;
> But it's not in this version of the patch.
> Thanks,
> --Natalie
> > --
> > James Cleverdon
> > IBM LTC (xSeries Linux Solutions)
> > {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
> > 


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
