Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbTFAWSu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264747AbTFAWSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:18:50 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:19654 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264746AbTFAWSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:18:48 -0400
Date: Sun, 1 Jun 2003 23:28:40 +0100
From: Stig Brautaset <stig@brautaset.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: scripts/Makefile.build fix
Message-ID: <20030601222840.GA13170@brautaset.org>
References: <fa.eruk8hn.73g20l@ifi.uio.no> <fa.hcaig7b.n72lar@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.hcaig7b.n72lar@ifi.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01 2003, Sam wrote:
> On Sun, Jun 01, 2003 at 07:43:35PM +0100, Stig Brautaset wrote:
> > Hi, 
> > 
> > This patch seems to fix `make V=0' for me.
> 
> Thanks for the patch.
> I do not see the broken behaviour here. Can you provide me with information
> about your system:
> Make version, shell, architecture, distribution.


I'm on a debian testing/unstable hybrid, and `uname -a' says:
Linux arwen 2.4.20 #1 Sun Jan 26 13:54:18 GMT 2003 i686 GNU/Linux

zsh/testing uptodate 4.0.6-30		# interactive shell
dash/testing uptodate 0.4.17		# /bin/sh
make/testing uptodate 3.80-1

> I got one report in private mail about make V=0 was broken, and would
> like to find out what is causing the problem.

I believe the problem occurs because (without my patch) the last three
lines of the following define is invoked in its own subshell, and
echoing the commands for that second subshell is not omitted.

define rule_vcc_o_c
        $(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)       \
        $(cmd_checksrc)                                                       \
        $(if $($(quiet)cmd_vcc_o_c),echo '  $($(quiet)cmd_vcc_o_c)';)         \
        $(cmd_vcc_o_c);                                                       \
                                                                              \
        if ! $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then         \
                mv $(@D)/.tmp_$(@F) $@;                                       \
        else                                                                  \
                $(CPP) -D__GENKSYMS__ $(c_flags) $<                           \
                | $(GENKSYMS)                                                 \
                > $(@D)/.tmp_$(@F:.o=.ver);                                   \
                                                                              \
                $(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F)                    \
                        -T $(@D)/.tmp_$(@F:.o=.ver);                          \
                rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);              \
        fi;                                                                   \
        scripts/fixdep $(depfile) $@ '$(cmd_vcc_o_c)' > $(@D)/.$(@F).tmp;     \
        rm -f $(depfile);                                                     \
        mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
endef




Stig
-- 
brautaset.org
