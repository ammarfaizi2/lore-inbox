Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933116AbWF3TUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbWF3TUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWF3TUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:20:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:7357 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S933116AbWF3TUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:20:46 -0400
Message-ID: <44A57957.60005@watson.ibm.com>
Date: Fri, 30 Jun 2006 15:19:51 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com>
In-Reply-To: <44A5770F.3080206@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Shailabh Nagar wrote:
> 
> 
<snip>

> Index: linux-2.6.17-mm3equiv/kernel/taskstats.c
> ===================================================================
> --- linux-2.6.17-mm3equiv.orig/kernel/taskstats.c	2006-06-30 11:57:14.000000000 -0400
> +++ linux-2.6.17-mm3equiv/kernel/taskstats.c	2006-06-30 13:58:36.000000000 -0400
> @@ -266,7 +266,7 @@ void taskstats_exit_send(struct task_str
>  	struct sk_buff *rep_skb;
>  	void *reply;
>  	size_t size;
> -	int is_thread_group;
> +	int is_thread_group, setid;
>  	struct nlattr *na;
> 
>  	if (!family_registered || !tidstats)
> @@ -320,7 +320,8 @@ void taskstats_exit_send(struct task_str
>  	nla_nest_end(rep_skb, na);
> 
>  send:
> -	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
> +	setid = (smp_processor_id()%TASKSTATS_CPUS_PER_SET)+1;
> +	send_reply(rep_skb, setid, TASKSTATS_MSG_MULTICAST);

This should be
	send_reply(rep_skb, setid, TASKSTATS_MSG_UNICAST);

>  	return;
> 
>  nla_put_failure:
> Index: linux-2.6.17-mm3equiv/Documentation/accounting/getdelays.c
> ===================================================================
> --- linux-2.6.17-mm3equiv.orig/Documentation/accounting/getdelays.c	2006-06-28 16:08:56.000000000 -0400
> +++ linux-2.6.17-mm3equiv/Documentation/accounting/getdelays.c	2006-06-30 14:09:28.000000000 -0400
> @@ -40,7 +40,7 @@ int done = 0;
>  /*
>   * Create a raw netlink socket and bind
>   */
> -static int create_nl_socket(int protocol, int groups)
> +static int create_nl_socket(int protocol, int cpugroup)
>  {
>      socklen_t addr_len;
>      int fd;
> @@ -52,7 +52,8 @@ static int create_nl_socket(int protocol
> 
>      memset(&local, 0, sizeof(local));
>      local.nl_family = AF_NETLINK;
> -    local.nl_groups = groups;
> +    local.nl_groups = TASKSTATS_LISTEN_GROUP;
> +    local.nl_pid = cpugroup;
> 
>      if (bind(fd, (struct sockaddr *) &local, sizeof(local)) < 0)
>  	goto error;
> @@ -203,7 +204,7 @@ int main(int argc, char *argv[])
>      pid_t rtid = 0;
>      int cmd_type = TASKSTATS_TYPE_TGID;
>      int c, status;
> -    int forking = 0;
> +    int forking = 0, cpugroup = 0;
>      struct sigaction act = {
>  	.sa_handler = SIG_IGN,
>  	.sa_mask = SA_NOMASK,
> @@ -222,7 +223,7 @@ int main(int argc, char *argv[])
> 
>      while (1) {
> 
> -	c = getopt(argc, argv, "t:p:c:");
> +	c = getopt(argc, argv, "t:p:c:g:l");
>  	if (c < 0)
>  	    break;
> 
> @@ -252,8 +253,14 @@ int main(int argc, char *argv[])
>  	    }
>  	    forking = 1;
>  	    break;
> +	case 'g':
> +		cpugroup = atoi(optarg);
> +		break;
> +	case 'l':
> +		loop = 1;
> +		break;
>  	default:
> -	    printf("usage %s [-t tgid][-p pid][-c cmd]\n", argv[0]);
> +	    printf("usage %s [-t tgid][-p pid][-c cmd][-g cpugroup][-l]\n", argv[0]);
>  	    exit(-1);
>  	    break;
>  	}
> @@ -266,7 +273,7 @@ int main(int argc, char *argv[])
>      /* Send Netlink request message & get reply */
> 
>      if ((nl_sd =
> -	 create_nl_socket(NETLINK_GENERIC, TASKSTATS_LISTEN_GROUP)) < 0)
> +	 create_nl_socket(NETLINK_GENERIC, cpugroup)) < 0)
>  	err(1, "error creating Netlink socket\n");
> 
> 
> @@ -287,10 +294,10 @@ int main(int argc, char *argv[])
> 
> 
>      if (!forking && sendto_fd(nl_sd, (char *) &req, req.n.nlmsg_len) < 0)
> +    if ((!forking && !loop) &&
> +	sendto_fd(nl_sd, (char *) &req, req.n.nlmsg_len) < 0)
>  	err(1, "error sending message via Netlink\n");
> 
> -    act.sa_handler = SIG_IGN;
> -    sigemptyset(&act.sa_mask);
>      if (sigaction(SIGINT, &act, NULL) < 0)
>  	err(1, "sigaction failed for SIGINT\n");
> 
> @@ -349,10 +356,11 @@ int main(int argc, char *argv[])
>  			rtid = *(int *) NLA_DATA(na);
>  			break;
>  		    case TASKSTATS_TYPE_STATS:
> -			if (rtid == tid) {
> +			if (rtid == tid || loop) {
>  			    print_taskstats((struct taskstats *)
>  					    NLA_DATA(na));
> -			    done = 1;
> +			    if (!loop)
> +				    done = 1;
>  			}
>  			break;
>  		    }
> @@ -369,7 +377,7 @@ int main(int argc, char *argv[])
>  	if (done)
>  	    break;
>      }
> -    while (1);
> +    while (loop);
> 
>      close(nl_sd);
>      return 0;
> 

