Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVHYTCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVHYTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVHYTCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:02:25 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:18414 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932349AbVHYTCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:02:24 -0400
Subject: Re: 2.6: how do I this in sysfs?
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       mochel@osdl.org, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10AB38B33@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF10AB38B33@cceexc23.americas.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+WxRSC4/HN9d1U+XxDIQ"
Date: Thu, 25 Aug 2005 13:02:09 -0600
Message-Id: <1124996530.23328.5.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+WxRSC4/HN9d1U+XxDIQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 13:52 -0500, Miller, Mike (OS Dev) wrote:
> I've been asked to pass this on for some kind of clarification.=20
> We have management apps requiring specific information from the Smart
> Array controller. We're trying to use sysfs to accomplish the task. An
> example of what we need to do is below. I'm sure some of you will
> recognize this as CSMI.
> The basic question is this: how do you pass complex data structures back
> and forth between user/kernelspace and still abide by the rules around
> sysfs like: one attribute per file, text files only, etc?

Wouldn't you be able to post these items in sysfs attributes in the SAS
transport layer, assuming the cciss driver used the SAS transport layer.
Then the LLDD would be responsible for retrieving/setting the attribute
using whatever method is appropriate (dma, request queues, etc).=20

I was hoping to start work on adding SDI operations to Christoph
Hellwig's SAS transport layer sometime next week. =20

Andrew

>=20
> Thanks,
> mikem
> >=20
> > We have a storage controller which has some features which=20
> > Work more or less as follows, but are not really "regular i/o"
> > In the sense that they are used for configuration or=20
> > management Of devices rather than being the primary purpose=20
> > of the devices.
> >=20
> > The host constructs a somewhat complex data buffer according=20
> > to a predefined convention, And fills out certain parts of=20
> > the buffer to formulate what could be a query, or perhaps=20
> > configuration data.
> > It then constructs a command which includes scatter gather=20
> > elements Which reference this data buffer, and writes the bus=20
> > address of the Command to a register on the controller.
> >=20
> > The controller reads the command and data buffer from host=20
> > memory, And DMAs the results of the query into the same data=20
> > buffer, and issues An interrupt to the host.  So there's a=20
> > bidirectional transfer Of data to/from the data buffer.
> >=20
> > For example, one the data buffers the controller understands=20
> > looks like what's below:
> >=20
> > User applications need to be able to use this interface to=20
> > talk To the controller.  What's the recommended way to=20
> > implement such An interface?
> >=20
> > // CC_CSMI_SAS_GET_PHY_INFO
> > typedef struct _COMMAND_HEADER {
> >    __u32 IOControllerNumber;
> > 	__u32 Length;
> > 	__u32 ReturnCode;
> > 	__u32 Timeout;
> > 	__u16 Direction;
> > } COMMAND_HEADER, *PCOMMAND_HEADER;
> >=20
> > typedef struct _CSMI_SAS_IDENTIFY {
> >    __u8  bDeviceType;
> >    __u8  bRestricted;
> >    __u8  bInitiatorPortProtocol;
> >    __u8  bTargetPortProtocol;
> >    __u8  bRestricted2[8];
> >    __u8  bSASAddress[8];
> >    __u8  bPhyIdentifier;
> >    __u8  bSignalClass;
> >    __u8  bReserved[6];
> > } CSMI_SAS_IDENTIFY,
> >   *PCSMI_SAS_IDENTIFY;
> >=20
> > typedef struct _CSMI_SAS_PHY_ENTITY {
> >    CSMI_SAS_IDENTIFY Identify;
> >    __u8  bPortIdentifier;
> >    __u8  bNegotiatedLinkRate;
> >    __u8  bMinimumLinkRate;
> >    __u8  bMaximumLinkRate;
> >    __u8  bPhyChangeCount;
> >    __u8  bAutoDiscover;
> >    __u8  bReserved[2];
> >    CSMI_SAS_IDENTIFY Attached;
> > } CSMI_SAS_PHY_ENTITY,
> >   *PCSMI_SAS_PHY_ENTITY;
> >=20
> > typedef struct _CSMI_SAS_PHY_INFO {
> >    __u8  bNumberOfPhys;
> >    __u8  bReserved[3];
> >    CSMI_SAS_PHY_ENTITY Phy[32];
> > } CSMI_SAS_PHY_INFO,
> >   *PCSMI_SAS_PHY_INFO;
> >=20
> > typedef struct _CSMI_SAS_PHY_INFO_BUFFER {
> >    COMMAND_HEADER IoctlHeader;
> >    CSMI_SAS_PHY_INFO Information;
> > } CSMI_SAS_PHY_INFO_BUFFER,
> >   *PCSMI_SAS_PHY_INFO_BUFFER;
> >=20
>=20

--=-+WxRSC4/HN9d1U+XxDIQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDDhWwoKXgdXvblSgRAnyYAJ9FvHMFRfxilLlgoRuX6JnTB5YfEQCg0nst
5U4B2ubCGhF6ZvDepe4Vo5s=
=sVyy
-----END PGP SIGNATURE-----

--=-+WxRSC4/HN9d1U+XxDIQ--

