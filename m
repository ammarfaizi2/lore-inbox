Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbSACRoe>; Thu, 3 Jan 2002 12:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287355AbSACRoY>; Thu, 3 Jan 2002 12:44:24 -0500
Received: from mxzilla1.xs4all.nl ([194.109.6.54]:2571 "EHLO
	mxzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287289AbSACRoQ>; Thu, 3 Jan 2002 12:44:16 -0500
Date: Thu, 3 Jan 2002 18:44:14 +0100
From: jtv <jtv@xs4all.nl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, paulus@samba.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103184414.D20936@xs4all.nl>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <15411.37817.753683.914033@argo.ozlabs.ibm.com> <877kr0uyc5.fsf@fadata.bg> <20020102233452.GQ1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103011905.D19933@xs4all.nl> <20020103002935.GT1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103020358.G19933@xs4all.nl> <20020103011709.GV1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020103011709.GV1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 06:17:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 06:17:09PM -0700, Tom Rini wrote:
> 
> I'm partial to Paul's' suggestion of redoing RELOC and friends in asm.

 
So am I--with the portable fallback of turning RELOC into an extern 
function.  As an added benefit, that would probably eliminate a lot 
of individual offset variables and hide the ugliness in a single place.

Just so it's documented, here's why I think the changes I coined earlier
won't work:

(1) Turn offset into an extern variable.

This doesn't work in cases like "strlen("string" + offset)", which the
compiler may translate to the equivalent of "strlen("string") - offset",
ie. "6 - offset" which of course still breaks.


(2) Cast to const volatile void *.

This *might* work, because gcc ought to suppress some optimizations upon
finding the 'volatile,' but the volatile would have to be cast out again
to make functions accept it as a nonvolatile parameter.  And if it's cast
out, gcc might decide to ignore it as well--or even perform its regular 
constant propagation regardless.  Not casting the volatile away again
OTOH might make the code a lot slower.


(3) Use -fPIC.

This isn't supported by all architectures, and requires special linker
support which may not be available yet at the time it's needed.

IIRC SAS/C used to have an option to allocate strings in the same
section of the object file as the code, and use PC-relative addressing
to get at them.  Anyone know if gcc has anything like that?  That should
also fix the problem by deferring computation of the string's address
to computation time.  Frankly though I don't even know if all 
architectures have PC-relative addressing...


> Well,  RELOC _always_ is doing funny arithmetic, and there's not much we
> can do about it.  At this point in the bootup we aren't running where
> things think we are yet, and have to adjust things as such.

The arithmetic can't be helped--agreed.  We just have to break some 
assumptions that gcc is allowed to make based on the information it has
and the C memory model.

Let's just make sure we break them beyond repair.  :-)


Jeroen

