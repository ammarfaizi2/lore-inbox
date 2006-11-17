Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755791AbWKQScV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbWKQScV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbWKQScV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:32:21 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:24494 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1755787AbWKQScU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:32:20 -0500
Subject: Re: [openib-general] [PATCH  09/13] Core WQE/CQE Types
From: Steve Wise <swise@opengridcomputing.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <455DFD23.8050504@pathscale.com>
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	 <20061116035912.22635.21736.stgit@dell3.ogc.int>
	 <455DFD23.8050504@pathscale.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 12:32:19 -0600
Message-Id: <1163788339.8457.95.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 10:19 -0800, Bryan O'Sullivan wrote:
> Steve Wise wrote:
> > T3 WQE and CQE structures, defines, etc...
> 
> I notice that none of the fields in these structs seem to be 
> endianness-annotated, but that there's a lot of cpu_to_be64 and so on 
> being used to frob values into them.  Please make sure that the driver 
> passes a sparse check, which it looks like it almost certainly cannot 
> right now.

It passes sparse with only a few warnings about calling memset() with a
size > 100000.  I don't know how to get around this warning, however,
because I indeed want to initialize large chunks of memory to zero using
memset...

The HW is BE.  So building WR's that get DMA'd to the adapter need
values in BE.  Also, pulling values out of the CQE require mapping back
to cpu byte order. 

> 
> > +#define RING_DOORBELL(doorbell, QPID) { \
> > +	(writel(((1<<31) | (QPID)), doorbell)); \
> > +}
> 
> Should probably be an inline function instead of a macro.
> 

Ok.


BTW: here is the sparse output:

vic13:/home/swise/git/linux-2.6.git # make C=1
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CHECK   drivers/infiniband/hw/cxgb3/iwch_cm.c
  CC [M]  drivers/infiniband/hw/cxgb3/iwch_cm.o
  CHECK   drivers/infiniband/hw/cxgb3/iwch_ev.c
  CC [M]  drivers/infiniband/hw/cxgb3/iwch_ev.o
  CHECK   drivers/infiniband/hw/cxgb3/iwch_cq.c
  CC [M]  drivers/infiniband/hw/cxgb3/iwch_cq.o
  CHECK   drivers/infiniband/hw/cxgb3/iwch_qp.c
  CC [M]  drivers/infiniband/hw/cxgb3/iwch_qp.o
  CHECK   drivers/infiniband/hw/cxgb3/iwch_mem.c
  CC [M]  drivers/infiniband/hw/cxgb3/iwch_mem.o
  CHECK   drivers/infiniband/hw/cxgb3/iwch_provider.c
  CC [M]  drivers/infiniband/hw/cxgb3/iwch_provider.o
  CHECK   drivers/infiniband/hw/cxgb3/iwch.c
drivers/infiniband/hw/cxgb3/iwch.c:70:8: warning: memset with byte count of 262144
drivers/infiniband/hw/cxgb3/iwch.c:70:8: warning: memset with byte count of 262144
drivers/infiniband/hw/cxgb3/iwch.c:70:8: warning: memset with byte count of 262144
  CC [M]  drivers/infiniband/hw/cxgb3/iwch.o
  CHECK   drivers/infiniband/hw/cxgb3/core/cxio_hal.c
drivers/infiniband/hw/cxgb3/core/cxio_hal.c:550:8: warning: memset with byte count of 131072
  CC [M]  drivers/infiniband/hw/cxgb3/core/cxio_hal.o
  CHECK   drivers/infiniband/hw/cxgb3/core/cxio_resource.c
  CC [M]  drivers/infiniband/hw/cxgb3/core/cxio_resource.o
  LD [M]  drivers/infiniband/hw/cxgb3/iw_cxgb3.o


