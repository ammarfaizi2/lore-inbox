Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUC2HKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 02:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUC2HKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 02:10:48 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54288 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262719AbUC2HKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 02:10:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Willy Tarreau <willy@w.ods.org>, Len Brown <len.brown@intel.com>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Mon, 29 Mar 2004 09:01:47 +0200
X-Mailer: KMail [version 1.4]
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local>
In-Reply-To: <20040329052238.GD1276@alpha.home.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403290901.47695.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 March 2004 07:22, Willy Tarreau wrote:
> Hi Len,
>
> On Sun, Mar 28, 2004 at 11:49:15PM -0500, Len Brown wrote:
> > ACPI unconditionally used cmpxchg before this change also -- from asm().
> > The asm() was broken, so we replaced it with C,
> > which invokes the cmpxchg macro, which isn't defined for
> > an 80386 build.
> >
> > I guess it is a build bug that the assembler allowed us
> > to invoke cmpxchg in an asm() for an 80386 build in earlier releases.
> >
> > I'm open to suggestions on the right way to fix this.
> >
> > 1. recommend CONFIG_ACPI=n for 80386 build.
> >
> > 2. force CONFIG_ACPI=n for 80386 build.
> >
> > 3. invoke cmpxchg from acpi even for 80386 build.
> >
> > 4. re-implement locks for the 80386 case.
>
> I like this one, but a simpler way : don't support SMP in this case, so
> that we won't have to play with locks. This would lead to something like
> this :

Yes, SMP makes sense only on 486+

> #ifndef CONFIG_X86_CMPXCHG
> #ifndef CONFIG_SMP
> #define cmpxchg(lock,old,new) ((*lock == old) ? ((*lock = new), old) :
> (*lock)) #else
> #define cmpxchg(lock,old,new) This_System_Is_Not_Supported
> #endif
> #endif
>
> This code (if valid) might be added to asm-i386/system.h so that we don't
> touch ACPI code.
>
> Any comments ?

Inline func please. We definitely don't want to evaluate
lock and old expressions several times.
-- 
vda
