Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVHYSwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVHYSwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHYSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:52:20 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:53946 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S932400AbVHYSwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:52:19 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: 2.6: how do I this in sysfs?
Date: Thu, 25 Aug 2005 13:52:14 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10AB38B33@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6: how do I this in sysfs?
Thread-index: AcWpotnodZRRTJoUQW6NxrMzzQE/UwAATAnA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, <mochel@osdl.org>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       "Luben Tuikov" <luben_tuikov@adaptec.com>,
       "Christoph Hellwig" <hch@infradead.org>
X-OriginalArrivalTime: 25 Aug 2005 18:52:15.0918 (UTC) FILETIME=[1C95ECE0:01C5A9A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been asked to pass this on for some kind of clarification. 
We have management apps requiring specific information from the Smart
Array controller. We're trying to use sysfs to accomplish the task. An
example of what we need to do is below. I'm sure some of you will
recognize this as CSMI.
The basic question is this: how do you pass complex data structures back
and forth between user/kernelspace and still abide by the rules around
sysfs like: one attribute per file, text files only, etc?

Thanks,
mikem
> 
> We have a storage controller which has some features which 
> Work more or less as follows, but are not really "regular i/o"
> In the sense that they are used for configuration or 
> management Of devices rather than being the primary purpose 
> of the devices.
> 
> The host constructs a somewhat complex data buffer according 
> to a predefined convention, And fills out certain parts of 
> the buffer to formulate what could be a query, or perhaps 
> configuration data.
> It then constructs a command which includes scatter gather 
> elements Which reference this data buffer, and writes the bus 
> address of the Command to a register on the controller.
> 
> The controller reads the command and data buffer from host 
> memory, And DMAs the results of the query into the same data 
> buffer, and issues An interrupt to the host.  So there's a 
> bidirectional transfer Of data to/from the data buffer.
> 
> For example, one the data buffers the controller understands 
> looks like what's below:
> 
> User applications need to be able to use this interface to 
> talk To the controller.  What's the recommended way to 
> implement such An interface?
> 
> // CC_CSMI_SAS_GET_PHY_INFO
> typedef struct _COMMAND_HEADER {
>    __u32 IOControllerNumber;
> 	__u32 Length;
> 	__u32 ReturnCode;
> 	__u32 Timeout;
> 	__u16 Direction;
> } COMMAND_HEADER, *PCOMMAND_HEADER;
> 
> typedef struct _CSMI_SAS_IDENTIFY {
>    __u8  bDeviceType;
>    __u8  bRestricted;
>    __u8  bInitiatorPortProtocol;
>    __u8  bTargetPortProtocol;
>    __u8  bRestricted2[8];
>    __u8  bSASAddress[8];
>    __u8  bPhyIdentifier;
>    __u8  bSignalClass;
>    __u8  bReserved[6];
> } CSMI_SAS_IDENTIFY,
>   *PCSMI_SAS_IDENTIFY;
> 
> typedef struct _CSMI_SAS_PHY_ENTITY {
>    CSMI_SAS_IDENTIFY Identify;
>    __u8  bPortIdentifier;
>    __u8  bNegotiatedLinkRate;
>    __u8  bMinimumLinkRate;
>    __u8  bMaximumLinkRate;
>    __u8  bPhyChangeCount;
>    __u8  bAutoDiscover;
>    __u8  bReserved[2];
>    CSMI_SAS_IDENTIFY Attached;
> } CSMI_SAS_PHY_ENTITY,
>   *PCSMI_SAS_PHY_ENTITY;
> 
> typedef struct _CSMI_SAS_PHY_INFO {
>    __u8  bNumberOfPhys;
>    __u8  bReserved[3];
>    CSMI_SAS_PHY_ENTITY Phy[32];
> } CSMI_SAS_PHY_INFO,
>   *PCSMI_SAS_PHY_INFO;
> 
> typedef struct _CSMI_SAS_PHY_INFO_BUFFER {
>    COMMAND_HEADER IoctlHeader;
>    CSMI_SAS_PHY_INFO Information;
> } CSMI_SAS_PHY_INFO_BUFFER,
>   *PCSMI_SAS_PHY_INFO_BUFFER;
> 
