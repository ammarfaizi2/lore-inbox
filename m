Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDEGvI>; Thu, 5 Apr 2001 02:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDEGu6>; Thu, 5 Apr 2001 02:50:58 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:60133 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S132563AbRDEGul>;
	Thu, 5 Apr 2001 02:50:41 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200104050649.XAA22384@csl.Stanford.EDU>
Subject: [CHECKER] __init functions called by non-__init
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Apr 2001 23:49:48 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as per a suggestion from Jonathan (jlundell@lobitos.net) I wrote a simple
checker to warn when non-__init functions call __init functions or use
__initdata.  Before sending the entire list of "bugs" I want to make
sure they actually are errors rather than bugs in how I understand the
kernel.   So, as I understand it, there seem to be two error cases:

	1. The best case: an init function calls a non-init, which in
	turn calls an init:

		void __init probe() { a(); }
		void a() { b(); }
		void __init b() { ... }

	in this case, is the missing __init on 'a' only a performance
	bug in that a's code won't be freed up?

	2. The worst case: some random post-initialization routine
	calls an __init routine which can cause the kernel to go into
	hyperspace if the __init routine's code has been deleted.

Are these error cases correct?  Are there other interesting, related
__init problems to look for?  The doc's I read were a little coy about
specifics.

There were about 43 errors flagged.  Most seem to be case 1.  An example:

/u2/engler/mc/oses/linux/2.4.1/drivers/scsi/g_NCR5380.c:240:generic_NCR53C400A_setup: ERROR:INIT: non-init fn 'generic_NCR53C400A_setup' calling init fn 'internal_setup'
/u2/engler/mc/oses/linux/2.4.1/drivers/scsi/g_NCR5380.c:253:generic_DTC3181E_setup: ERROR:INIT: non-init fn 'generic_DTC3181E_setup' calling init fn 'internal_setup'


where if you look in the code, the flagged routine generic_NCR53C400A_setup 
does indeed not have __init:
	void generic_NCR53C400A_setup (char *str, int *ints) {
    		internal_setup (BOARD_NCR53C400A, str, ints);
	}

but a nearby, almost identiical routine does:

	void __init generic_NCR53C400_setup (char *str, int *ints){
    		internal_setup (BOARD_NCR53C400, str, ints);
	}

This just seems to be a case where someone forgot to type the __init
in, thereby causing a (small) storage leak.

-----------------------------------------------------------------

On the other hand, if I understood the rules right, this next one looks like
a more exciting error, since an __exit routine is calling an __init routine:

/u2/engler/mc/oses/linux/2.4.1/drivers/sound/aedsp16.c:1356:cleanup_aedsp16: ERROR:INIT: non-init fn 'cleanup_aedsp16' calling init fn 'uninit_aedsp16'

void __init uninit_aedsp16(void)
{
        if (ae_config.mss_base != -1)
                uninit_aedsp16_mss();
        else
                uninit_aedsp16_sb();
        if (ae_config.mpu_base != -1)
                uninit_aedsp16_mpu();
}


static void __exit cleanup_aedsp16(void) {
        uninit_aedsp16();
}
-----------------------------------------------------------------

Any clarifications, etc would be appreciated. 

Thanks,
Dawson
