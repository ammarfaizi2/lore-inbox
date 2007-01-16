Return-Path: <linux-kernel-owner+w=401wt.eu-S1751170AbXAPNyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXAPNyi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbXAPNyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:54:37 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:45193 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751170AbXAPNyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:54:37 -0500
Message-ID: <45ACD918.2040204@scientia.net>
Date: Tue, 16 Jan 2007 14:54:32 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org, cw@f00f.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca>
In-Reply-To: <45AC1AEB.60805@shaw.ca>
Content-Type: multipart/mixed;
 boundary="------------030803000904020905080305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030803000904020905080305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Robert Hancock wrote:
>> What is that GART thing exactly? Is this the hardware IOMMU? I've always
>> thought GART was something graphics card related,.. but if so,.. how
>> could this solve our problem (that seems to occur mainly on harddisks)?
>>     
> The GART built into the Athlon 64/Opteron CPUs is normally used for 
> remapping graphics memory so that an AGP graphics card can see 
> physically non-contiguous memory as one contiguous region. However, 
> Linux can also use it as an IOMMU which allows devices which normally 
> can't access memory above 4GB to see a mapping of that memory that 
> resides below 4GB. In pre-2.6.20 kernels both the SATA and PATA 
> controllers on the nForce 4 chipsets can only access memory below 4GB so 
> transfers to memory above this mark have to go through the IOMMU. In 
> 2.6.20 this limitation is lifted on the nForce4 SATA controllers.
>   
Ah, I see. Thanks for that introduction :-)


>> Does this mean that PATA is no related? The corruption appears on PATA
>> disks to, so why should it only solve the issue at SATA disks? Sounds a
>> bit strange to me?
>>     
> The PATA controller will still be using 32-bit DMA and so may also use 
> the IOMMU, so this problem would not be avoided.
>   
>   
>> Can you explain this a little bit more please? Is this a drawback (like
>> a performance decrease)? Like under Windows where they never use the
>> hardware iommu but always do it via software?
>>     
>
> No, it shouldn't cause any performance loss. In previous kernels the 
> nForce4 SATA controller was controlled using an interface quite similar 
> to a PATA controller. In 2.6.20 kernels they use a more efficient 
> interface that NVidia calls ADMA, which in addition to supporting NCQ 
> also supports DMA without any 4GB limitations, so it can access all 
> memory directly without requiring IOMMU assistance.
>
> Note that if this corruption problem is, as has been suggested, related 
> to memory hole remapping and the IOMMU, then this change only prevents 
> the SATA controller transfers from experiencing this problem. Transfers 
> on the PATA controller as well as any other devices with 32-bit DMA 
> limitations might still have problems. As such this really just avoids 
> the problem, not fixes it.
>   
Ok,.. that sounds reasonable,.. so the whole thing might (!) actually be
a hardware design error,... but we just don't use that hardware any
longer when accessing devices via sata_nv.

So this doesn't solve our problem with PATA drives or other devices
(although we had until now no reports of errors with other devices) and
we have to stick with iommu=soft.

If one use iommu=soft the sata_nv will continue to use the new code for
the ADMA, right?


Best wishes,
Chris.

--------------030803000904020905080305
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030803000904020905080305--
