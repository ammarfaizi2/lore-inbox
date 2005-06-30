Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVF3MVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVF3MVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVF3MVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 08:21:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46291 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262960AbVF3MVD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 08:21:03 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] deinline sleep/delay functions
Date: Thu, 30 Jun 2005 15:20:49 +0300
User-Agent: KMail/1.5.4
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <200506301444.51463.vda@ilport.com.ua> <20050630130454.C16103@flint.arm.linux.org.uk>
In-Reply-To: <20050630130454.C16103@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506301520.49371.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 15:04, Russell King wrote:
> On Thu, Jun 30, 2005 at 02:44:51PM +0300, Denis Vlasenko wrote:
> > On Thursday 30 June 2005 14:21, Russell King wrote:
> > > The maximum delay is dependent on the architecture implementation,
> > > and it depends on bogomips.  There is no one single value for it.
> > > Architectures have to decide this from the way that they do the
> > > math and the expected range of bogomips.
> > 
> > In example I posted these limitations are lifted. Granted these
> > limitations were not critical, but removing them can't do harm,
> > I guess?
> 
> They're lifted poorly.  You include a mandatory division in the path.
> On systems where division has to be done in code, this is not acceptable,
> especially when we're trying to get short delays on embedded CPUs
> running below 100MHz.  The time it takes to do the division could
> swamp the required delay value.

What divisions? Where?

void udelay(unsigned int usecs)
{
        unsigned int k = usecs/1024;
        while (k--)
                __udelay(1024);
        __udelay(usecs % 1024);
}

I see no divisions. I see shifts and ANDs.
I can code them explicitly:

void udelay(unsigned int usecs)
{
        unsigned int k = usecs >> 10; /* divide by 1024 */
        while (k--)
                __udelay(0x400); /* 1024 */
        __udelay(usecs & 0x3ff); /* mod 1024 */
}

Should be ok now.
--
vda

