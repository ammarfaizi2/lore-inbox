Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUAEUA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUAEUAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:00:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30367 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265343AbUAEUAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:00:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
Date: Mon, 5 Jan 2004 11:41:52 -0800
User-Agent: KMail/1.4.1
Cc: Berkley Shands <berkley@cs.wustl.edu>
References: <2938942704.1073325455@aslan.btc.adaptec.com>
In-Reply-To: <2938942704.1073325455@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200401051141.52236.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 January 2004 09:57 am, Justin T. Gibbs wrote:
> Berkley Shands recently tripped over this problem.  The 2.6.X pci_map_sg
> code for x86_64 modifies the passed in S/G list to compact it for mapping
> by the GART.  This modification is not reversed when pci_unmap_sg is
> called.  In the case of a retried SCSI command, this causes any attempt
> to map the command a second time to fail with a BUG assertion since the
> nseg parameter passed into the second map call is state.  nseg comes from
> the "use_sg" field in the SCSI command structure which is never touched
> by the HBA drivers invoking pci_map_sg.
>
> DMA-API.txt doesn't seem to cover this issue.  Should the low-level DMA
> code restore the S/G list to its original state on unmap or should the
> SCSI HBA drivers be changed to update "use_sg" with the segment count
> reported by the pci_map_sg() API?  If the latter, this seems to contradict
> the mandate in DMA-API that the nseg parameter passed into the unmap call
> be the same as that passed into the map call.  Most of the kernel assumes
> that an S/G list can be mapped an unmapped multiple times using the same
> arguments.  This doesn't seem to me to be an unreasonable expectation.

Hi,

I ran into the same thing a month ago. I talked to Andi Kleen about this.
He seems to think that, it is okay to modify the sg-list in pci_map_sg().
pci_unmap_sg() can't restore it back, since we lost lot of information.
One option is to recreate entire sg-list in case of a retry. I used a patch 
similar to following to do this. Is this acceptable ?

Thanks,
Badari

--- scsi_lib.c  2004-01-04 19:53:56.000000000 -0800
+++ scsi_lib.c.new      2004-01-04 19:57:35.000000000 -0800
@@ -308,6 +308,13 @@ void scsi_setup_cmd_retry(struct scsi_cm
        cmd->cmd_len = cmd->old_cmd_len;
        cmd->sc_data_direction = cmd->sc_old_data_direction;
        cmd->underflow = cmd->old_underflow;
+       if (cmd->use_sg) {
+               struct request     *req = cmd->request;
+               int count;
+
+               count = blk_rq_map_sg(req->q, req, cmd->request_buffer);
+               BUG_ON(count != cmd->use_sg);
+       }
 }


