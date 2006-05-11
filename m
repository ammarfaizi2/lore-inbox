Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWEKSYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWEKSYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWEKSYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:24:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:19291 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750740AbWEKSYK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:24:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=miABqFcGDGAiZI2i8ILDtea0QSZ6uvUn0udgEuW1RVBYJocI4MQDc0tIqjJA9kFOFYD9yzysmmSOooDgm+vRifShZseAmdfAWsemPTetvhsgx34rpsXBjZP1suND6HPoOaRKbuc89tY8NogIUqkx/Fmm1GVoUZub6uNO4cuTU/I=
Message-ID: <15ddcffd0605111124v390e1dbei18508787ec29afac@mail.gmail.com>
Date: Thu, 11 May 2006 20:24:09 +0200
From: "Or Gerlitz" <or.gerlitz@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: [openib-general] [PATCH 6/6] iSER Kconfig and Makefile
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       michaelc@cs.wisc.edu, James.Bottomley@SteelEye.com
In-Reply-To: <adau07w1nks.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0605111003160.18975-100000@zuben>
	 <adau07w1nks.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/06, Roland Dreier <rdreier@cisco.com> wrote:
> I fixed up this patch so that it actually hooks into the build (as
> below).  (BTW, when sending patches in the future, please make them
> apply with "-p1" -- your patches had paths like
>
>     /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Kconfig
>
> so I had to manually strip off the /usr/src/)

OK, will do that.

>
> Anyway, with a config like
>
>     CONFIG_SCSI_ISCSI_ATTRS=y
>     # CONFIG_ISCSI_TCP is not set
>     CONFIG_INFINIBAND_ISER=y
>
> My build fails with a bunch of errors like:
>
>     drivers/built-in.o: In function `iser_comp_error_worker':iser_verbs.c:(.text+0x7d7cd): undefined reference to `iscsi_conn_failure'
>
> and so on.  Is the correct fix for this to add
>
> obj-$(CONFIG_INFINIBAND_ISER)   += libiscsi.o
>
> to drivers/scsi/Makefile?

Indeed since libiscsi does not have a CONFIG_ of its own, you need to
set CONFIG_ISCSI_TCP to have libiscsi being built and then iser links
with it.

So there are two options here: either to set a CONFIG_LIBISCSI and
select it by both CONFIG_ISCSI_TCP and CONFIG_INFINIBAND_ISER or the
approach you were suggesting. I am cc-ing Mike Christie and James
Bottomley on this email, if you guys have a preference, let me know
and i can produce a patch to drivers/scsi/Kconfig and Makefile.

> Also, I get the following sparse warning:
>
>     drivers/infiniband/ulp/iser/iser_initiator.c:610:25: error: incompatible types for operation (&)
>
> and the code there does look fishy:
>
>         itt = hdr->itt & ISCSI_ITT_MASK; /* mask out cid and age bits */
>
> hdr->itt is __be32 but ISCSI_ITT_MASK is just (0xfff), so it seems
> that there is something wrong, either with the iSCSI endianness
> annotation or with the code itself.

What's little wrong here is that hdr->itt is __be32 but it never gets
htonl-ed before placing on the wire so i can't ntohl it back before
AND-ing it with the ITT_MASK. Its only little wrong b/c in a way the
target treats the ITT (Initiator Task Tag) as an opaque tag and hence
it just returns on the command/control response the itt of the
command/control.

At the bottom line, its need to be fixed by converting the itt to
network order in libiscsi and then converting it to host order in iser
before doing the arthimetic AND, so the sparse endianess related
warning will be gone. I  will be able to fix that on Sunday and send
the fixes to linux-scsi and openib.

> Thanks,
>   Roland

Thanks to you for pointing these issues, also, in drivers/infiniband/Makefile

> +obj-$(CONFIG_INFINIBAND_SRP)           += ulp/iser/

should be

> +obj-$(CONFIG_INFINIBAND_ISER)           += ulp/iser/

Or.

> diff-tree 9120bc6c8b5bdd1f4c85df7a04779ae8faa0c1a5 (from 4161cba09429dae06d249584ee1c7d63c672422c)
> Author: Or Gerlitz <ogerlitz@voltaire.com>
> Date:   Thu May 11 10:03:30 2006 +0300
>
>     IB/iser: iSER Kconfig and Makefile
>
>     Kconfig and Makefile for iSER.
>
>     Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
>     Signed-off-by: Roland Dreier <rolandd@cisco.com>
>
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index ba2d650..69a53d4 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -41,4 +41,6 @@ source "drivers/infiniband/ulp/ipoib/Kco
>
>  source "drivers/infiniband/ulp/srp/Kconfig"
>
> +source "drivers/infiniband/ulp/iser/Kconfig"
> +
>  endmenu
> diff --git a/drivers/infiniband/Makefile b/drivers/infiniband/Makefile
> index eea2732..abeaf79 100644
> --- a/drivers/infiniband/Makefile
> +++ b/drivers/infiniband/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_INFINIBAND_MTHCA)          += hw/mt
>  obj-$(CONFIG_IPATH_CORE)               += hw/ipath/
>  obj-$(CONFIG_INFINIBAND_IPOIB)         += ulp/ipoib/
>  obj-$(CONFIG_INFINIBAND_SRP)           += ulp/srp/
> +obj-$(CONFIG_INFINIBAND_SRP)           += ulp/iser/
> diff --git a/drivers/infiniband/ulp/iser/Kconfig b/drivers/infiniband/ulp/iser/Kconfig
> new file mode 100644
> index 0000000..fead87d
> --- /dev/null
> +++ b/drivers/infiniband/ulp/iser/Kconfig
> @@ -0,0 +1,11 @@
> +config INFINIBAND_ISER
> +       tristate "ISCSI RDMA Protocol"
> +       depends on INFINIBAND && SCSI
> +       select SCSI_ISCSI_ATTRS
> +       ---help---
> +         Support for the ISCSI RDMA Protocol over InfiniBand.  This
> +         allows you to access storage devices that speak ISER/ISCSI
> +         over InfiniBand.
> +
> +         The ISER protocol is defined by IETF.
> +         See <http://www.ietf.org/>.
> diff --git a/drivers/infiniband/ulp/iser/Makefile b/drivers/infiniband/ulp/iser/Makefile
> new file mode 100644
> index 0000000..fe6cd15
> --- /dev/null
> +++ b/drivers/infiniband/ulp/iser/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_INFINIBAND_ISER)  += ib_iser.o
> +
> +ib_iser-y                      := iser_verbs.o iser_initiator.o iser_memory.o \
> +                                  iscsi_iser.o
