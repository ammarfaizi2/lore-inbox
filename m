Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVBFESe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVBFESe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbVBFESe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:18:34 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:20659
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261943AbVBFES2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:18:28 -0500
Date: Sat, 5 Feb 2005 20:10:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-Id: <20050205201044.1b95f4e8.davem@davemloft.net>
In-Reply-To: <20050205064643.GA29758@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
	<20050205052407.GA17266@gondor.apana.org.au>
	<20050204213813.4bd642ad.davem@davemloft.net>
	<20050205061110.GA18275@gondor.apana.org.au>
	<20050204221344.247548cb.davem@davemloft.net>
	<20050205064643.GA29758@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 17:46:43 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This doesn't work because net/core/dst.c can only search based
> on dst->dev.  For the split device case, dst->dev is set to
> loopback_dev while rt6i_idev is set to the real device.

Indeed.  I didn't catch that.

> If we wanted to preserve the split device semantics, then we
> can create a local GC list in IPv6 so that it can search based
> on rt6i_idev as well as the other keys.

Ok, so this would entail changing each ipv6 dst_free() call
into one to ip6_dst_free(), which would:

	ip6_garbage_add(dst);
	dst_free(dst);

It would mean that dst_run_gc() would need to have some callback
like dst->ops->gc_destroy() or similar, which would allow ipv6
to delete the dst from it's local garbage list.

> Alternatively we can
> remove the dst->dev == dev check in dst_dev_event and dst_ifdown
> and move that test down to the individual ifdown functions.

I think there is a hole in this idea.... maybe.

If the idea is to scan dst_garbage_list down in ipv6 specific code,
you can't do that since 'dst' objects from every pool in the kernel
get put onto the dst_garbage_list.   It is generic.

They have no identity, so it's illegal to treat any member of that
list as an rt_entry, rt6_entry or any specific higher level dst
type.
