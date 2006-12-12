Return-Path: <linux-kernel-owner+w=401wt.eu-S932136AbWLLHkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWLLHkS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 02:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWLLHkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 02:40:18 -0500
Received: from web36002.mail.mud.yahoo.com ([66.163.179.201]:33341 "HELO
	web36002.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932136AbWLLHkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 02:40:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=rDPbpvuWXcmDf40TPzLZsLZzPEBTtcQIzI1OpjSLG+ja0WWYyP8yn3DGWwbuHxRGBq2lnIVpd1eSX6rmddHih1FRuJj+Lolwwvl4WbIwRYMxJGBNdPYCfxizHS4wKvThkkY1Ge4yhloQsPpbsfMSDX2gtWgwFABsUPCd3tUAv3Y=;
X-YMail-OSG: _dfceWEVM1nfsl17ZgRl9E8F.dIJAb16P7.fsMwv.S5cMxmonNx2lyTGuI41LFP_ptdnLJaCF.pc2gQv2NlT0HPd4Fzyy5eokUk_VhVpx9K8Un_z0UN6vLomc13QV417_cKMvYOFqmE6DkY-
Date: Mon, 11 Dec 2006 23:40:16 -0800 (PST)
From: linuxer linuxer <tangzt@yahoo.com>
Subject: hi, should these code is a problem in nfs system clnt.c?
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <319714.29242.qm@web36002.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone: 
    I am a newbie, if my question waste your time, I
am sorry for that. 

    In clnt.c file ,call_timeout function:    
    I suggest the code that judge whether the network
link status is down should be added, won't they? 
    I tested it with one Ethernet netcard.

static void
call_timeout(struct rpc_task *task)
{
	struct rpc_clnt	*clnt = task->tk_client;

+       struct netdev * dev;
+       if ((dev = __dev_get_by_name("eth0")) == 
+        NULL){
+		rpc_exit(task, -ENOTCONN);
+		return;
+    	}
+	else{
+   		 if (!netif_carrier_ok(dev)){
+  			rpc_exit(task, -ENOTCONN);
+			return;
+  		 }
+     	}

	if (xprt_adjust_timeout(task->tk_rqstp) == 0) {
		dprintk("RPC: %4d call_timeout (minor)\n",
task->tk_pid);
		goto retry;
	}

	dprintk("RPC: %4d call_timeout (major)\n",
task->tk_pid);
	task->tk_timeouts++;

	if (RPC_IS_SOFT(task)) {
		printk(KERN_NOTICE "%s: server %s not responding,
timed out\n",
				clnt->cl_protname, clnt->cl_server);
		rpc_exit(task, -EIO);
		return;
	}

	if (!(task->tk_flags & RPC_CALL_MAJORSEEN)) {
		task->tk_flags |= RPC_CALL_MAJORSEEN;
		printk(KERN_NOTICE "%s: server %s not responding,
still trying\n",
			clnt->cl_protname, clnt->cl_server);
	}
	rpc_force_rebind(clnt);

retry:
	clnt->cl_stats->rpcretrans++;
	task->tk_action = call_bind;
	task->tk_status = 0;
}



 
____________________________________________________________________________________
Yahoo! Music Unlimited
Access over 1 million songs.
http://music.yahoo.com/unlimited
