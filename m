Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268944AbTBZWMD>; Wed, 26 Feb 2003 17:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268952AbTBZWMC>; Wed, 26 Feb 2003 17:12:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48536 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268944AbTBZWMC>; Wed, 26 Feb 2003 17:12:02 -0500
Date: Wed, 26 Feb 2003 17:22:13 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>, jt@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030226172213.O3910@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <873cmbghai.fsf@student.uni-tuebingen.de> <200302262047.h1QKlm0P001784@eeyore.valparaiso.cl> <20030226205754.GA29466@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030226205754.GA29466@nevyn.them.org>; from dan@debian.org on Wed, Feb 26, 2003 at 03:57:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 03:57:54PM -0500, Daniel Jacobowitz wrote:
> > > > > 	if((stream + event_len) < ends) {
> > > > > 		iwe->len = event_len;
> > > > > 		memcpy(stream, (char *) iwe, event_len);
> > > > > 		stream += event_len;
> > > > > 	}
> > > > > 	return stream;

> > > > The compiler is free to assume char *stream and struct iw_event *iwe
> > > > point to separate areas of memory, due to strict aliasing.

No.

> Stream is not the same storage as iwe, so this is hardly the issue. 
> Writes to stream don't affect iwe.  The problem was the assignment to
> iwe->len being moved after the access, according to the report.

GCC can do that with -fstrict-aliasing:
All calls to this inline function are done with constant event_len.
E.g. in case of event_len = IW_EV_UINT_LEN, memcpy macro expands to
__constant_memcpy which does:
                        *(unsigned long *)to = *(const unsigned long *)from;
                        *(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
iwe->len is unsigned short and the code writes the value as
unsigned short (iwe->len = 8) and then reads the same memory as unsigned
long (something = *(const unsigned long *)(char *)iwe). But those two types
cannot alias and thus gcc can reorder them.

To fix that, __constant_memcpy would have to access the data through
union, ir you could as well forget about __constant_memcpy and use
__builtin_memcpy where gcc will take care about the constant copying.

	Jakub
