Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262300AbREXVMk>; Thu, 24 May 2001 17:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbREXVMW>; Thu, 24 May 2001 17:12:22 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:5853 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262300AbREXVMD>;
	Thu, 24 May 2001 17:12:03 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105242112.OAA29801@csl.Stanford.EDU>
Subject: [CHECKER] user-pointer bugs in 2.4.4 and 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Thu, 24 May 2001 14:12:02 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed are 10 probable security holes where code treats a pointer as
a bad user pointer in one place (by passing it as an argument to a
*_user or verify_area routine) but then dereferences it, or passes it
to a routine that does dereference it somewhere else.

We've reported many of these bugs before. 

	Summary for 
		2.4.4ac8-specific errors       = 4
		2.4.4-specific errors = 0
		Common errors 		      	  = 6
		Total 				  = 10

Dawson

# BUGs	|	File Name
5	|	drivers/isdn/eicon/linchr.c
3	|	drivers/net/appletalk/ipddp.c
1	|	net/decnet/af_decnet.c
1	|	drivers/telephony/ixj.c

############################################################
# 2.4.4ac8 specific errors
#
---------------------------------------------------------
[BUG] supposed to at least be bad form.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:64:do_ioctl: ERROR:PARAM:62:64: tainted var 'pDivaConfig' (from line 62) used as arg 0 to 'DivasCardConfig'
	switch (command)
	{
		case DIA_IOCTL_CONFIG:
			pDivaConfig = (dia_config_t *) arg;
			
Start --->
			if (!verify_area(VERIFY_READ, pDivaConfig, sizeof(dia_config_t)))
			{
Error --->
				DivasCardConfig(pDivaConfig);
			}
			else
			{
---------------------------------------------------------
[BUG]supposed to at least be bad form.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:186:do_ioctl: ERROR:PARAM:184:186: tainted var 'mem_block' (from line 184) used as arg 0 to 'DivasGetMem'
			return 0;

		case DIA_IOCTL_GET_MEM:
			mem_block = (mem_block_t *) arg;
			
Start --->
			if (!verify_area(VERIFY_WRITE, mem_block, sizeof(mem_block_t)))
			{
Error --->
				DivasGetMem(mem_block);
			}
			else
			{
---------------------------------------------------------
[BUG]supposed to at least be bad form.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:131:do_ioctl: ERROR:PARAM:129:131: tainted var 'pDivaLog' (from line 129) used as arg 0 to 'DivasLog'
			return 0;

		case DIA_IOCTL_LOG:
			pDivaLog = (dia_log_t *) arg;
			
Start --->
			if (!verify_area(VERIFY_READ, pDivaLog, sizeof(dia_log_t)))
			{
Error --->
				DivasLog(pDivaLog);
			}
			else
			{
---------------------------------------------------------
[BUG]supposed to at least be bad form.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:172:do_ioctl: ERROR:PARAM:142:172: tainted var 'arg' (from line 142) used as arg 0 to 'DivasGetList'
			}
			return 0;

		case DIA_IOCTL_XLOG_REQ:
			
Start --->
			if (!verify_area(VERIFY_READ, (void *)arg, sizeof(word)))

	... DELETED 24 lines ...

		case DIA_IOCTL_GET_LIST:
			DPRINTF(("divas: DIA_IOCTL_GET_LIST"));
			
			if (!verify_area(VERIFY_WRITE, (void *)arg, sizeof(dia_card_list_t)))
			{
Error --->
				DivasGetList((dia_card_list_t *)arg);
			}
			else
			{


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/appletalk/ipddp.c:268:ipddp_ioctl: ERROR:PARAM:268:268: tainted var 'rt' (from line 268) used as arg 0 to 'ipddp_find_route'
        {
		case SIOCADDIPDDPRT:
                        return (ipddp_create(rt));

                case SIOCFINDIPDDPRT:

Error --->
                        if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
---------------------------------------------------------
[BUG] but minor i think
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:97:do_ioctl: ERROR:PARAM:95:97: Deref tainted var 'pDivaStart' (tainted from line 95)
			return 0;

		case DIA_IOCTL_START:
			pDivaStart = (dia_start_t *) arg;
			
Start --->
			if (!verify_area(VERIFY_READ, pDivaStart, sizeof(dia_start_t)))
			{
Error --->
				return DivasCardStart(pDivaStart->card_id);
			}
			else
			{
---------------------------------------------------------
[BUG]
	ipddp_find derefs this struct.
	struct at_addr
	{
        	__u16   s_net;
        	__u8    s_node;
	};
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/appletalk/ipddp.c:265:ipddp_ioctl: ERROR:PARAM:268:265: tainted var 'rt' (from line 268) used as arg 0 to 'ipddp_create'
                return -EPERM;

        switch(cmd)
        {
		case SIOCADDIPDDPRT:
Error --->
                        return (ipddp_create(rt));

                case SIOCFINDIPDDPRT:
Start --->
                        if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
                                return -EFAULT;
                        return 0;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/appletalk/ipddp.c:273:ipddp_ioctl: ERROR:PARAM:268:273: tainted var 'rt' (from line 268) used as arg 0 to 'ipddp_delete'
        {
		case SIOCADDIPDDPRT:
                        return (ipddp_create(rt));

                case SIOCFINDIPDDPRT:
Start --->
                        if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
                                return -EFAULT;
                        return 0;

                case SIOCDELIPDDPRT:
Error --->
                        return (ipddp_delete(rt));

                default:
                        return -EINVAL;
---------------------------------------------------------
[BUG]  seems pretty confused.
/u2/engler/mc/oses/linux/2.4.4-ac8/net/decnet/af_decnet.c:1491:__dn_getsockopt: ERROR:PARAM:1438:1491: Deref tainted var 'optlen' (tainted from line 1438)
	struct linkinfo_dn link;
	unsigned int r_len;
	void *r_data = NULL;
	unsigned int val;

Start --->
	if(get_user(r_len , optlen))

	... DELETED 47 lines ...

			break;

		default:
#ifdef CONFIG_NETFILTER
		{
Error --->
			int val, len = *optlen;
			val = nf_getsockopt(sk, PF_DECnet, optname, 
							optval, &len);
			if (val >= 0)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/telephony/ixj.c:5063:ixj_ioctl: ERROR:PARAM:4702:5063: tainted var 'arg' (from line 4702) used as arg 1 to 'capabilities_check'
		break;
	case IXJCTL_SERIAL:
		retval = j->serial;
		break;
	case IXJCTL_VERSION:
Start --->
		if (copy_to_user((char *) arg, ixj_c_revision, strlen(ixj_c_revision)))

	... DELETED 355 lines ...

	case PHONE_CAPABILITIES_LIST:
		if (copy_to_user((char *) arg, j->caplist, sizeof(struct phone_capability) * j->caps))
			 return -EFAULT;
		break;
	case PHONE_CAPABILITIES_CHECK:
Error --->
		retval = capabilities_check(j, (struct phone_capability *) arg);
		break;
	case PHONE_PSTN_SET_STATE:
		daa_set_mode(j, arg);

