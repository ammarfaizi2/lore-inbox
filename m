Return-Path: <linux-kernel-owner+w=401wt.eu-S932839AbXASBuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbXASBuj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 20:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbXASBuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 20:50:39 -0500
Received: from web36709.mail.mud.yahoo.com ([209.191.85.43]:24140 "HELO
	web36709.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932839AbXASBui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 20:50:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iepUXJmcO253epEeoftn+97qQhUKY88AiLMTuHoJ10RG5lSDtlHTlqGnUvq3ioJXq/5f9mjyBaU8gxZnL4sOhcSIWxitP6WVtbUM27hXsaKZ27O90K0kMYm2dN15Wi7awdA85rmTe+gLKPxRA8towyqxZf4svJ6r/F4NkcCxVuc=  ;
Message-ID: <20070119015037.8318.qmail@web36709.mail.mud.yahoo.com>
X-YMail-OSG: wm9BbeoVM1lHwq0z0Ee.BLJ_VsSiqgQ1YbQh_lTGxmLoEfjFdCnqpRlbLPbAOG.ek28uvc5F1vIxeadRXDIn5tu6eFi4QHgkTHsxgvdhWAWBYwvVUOM-
Date: Thu, 18 Jan 2007 17:50:37 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: mmc: correct semantics of the mmc_host_remove
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A53856.7060209@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

It appears to me that under certain circumstances mmc layer will issue requests to the host after
mmc_host_remove returns. This happens, for example, in tifm_sd driver because mmc_host may be
removed mid-transfer, as the socket shall be freed for possible reuse by different media type.
Currently, the only solution is to sleep a little somewhere after mmc_remove_host but before
mmc_free_host. I think the correct way to handle the situation is to ensure that mmc_host is never
accessed by the mmc layer after mmc_remove_host returns.


I think a easy way to handle this is to modify __mmc_claim_host to fail if the mmc_host is marked
for removal (this implies that its return value should be checked on use, which is not currently
the case everywhere). This way, mmc_host_remove can claim host, mark it as "dead" and then return
safely knowing that nobody will send any more requests to the host. 

Some questions:
1. Will this suffice for the task? 
2. Are there any reasons not to do this?
3. Is it possible to replace the fancy locking loop in the __mmc_claim_host with mutex based
locking (mutex does the same thing, isn't it)?



 
____________________________________________________________________________________
Get your own web address.  
Have a HUGE year through Yahoo! Small Business.
http://smallbusiness.yahoo.com/domains/?p=BESTDEAL
