Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWBHFSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWBHFSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWBHFSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:18:43 -0500
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:57266 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S1030524AbWBHFSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:18:42 -0500
Date: Tue, 7 Feb 2006 21:13:57 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: build breakage scripts/kconfig/conf
Message-ID: <20060208051357.GA32025@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

barbeque/zarathustra:linux-2.6: SHELL=/bin/bash make oldconfig
  HOSTLD  scripts/kconfig/conf
/usr/bin/ld: cannot find -lintl
collect2: ld returned 1 exit status
make[1]: *** [scripts/kconfig/conf] Error 1
make: *** [oldconfig] Error 2

by:
5e375bc7d586e0df971734a5a5f1f080ffd89b68
[PATCH] kconfig: detect if -lintl is needed when linking conf,mconf

  KBUILD_NEED_LINTL := $(shell \
    if echo -e "\#include <libintl.h>\nint main(int a, char** b) { gettext(\"\"); return 0; }\n" | \
      $(HOSTCC) $(HOSTCFLAGS) -x c - -o /dev/null> /dev/null 2>&1 ; \
    then echo no ; \
    else echo yes ; fi)
  ifeq ($(KBUILD_NEED_LINTL),yes)
    HOSTLOADLIBES_conf += -lintl
    HOSTLOADLIBES_mconf        += -lintl
  endif

Running the commands manually, it returns the correct values.
Running it via make, it pukes.

Tried adding SHELL=/bin/bash to the Makefile fragment, and also tried:
SHELL=/bin/bash
KBUILD_NEED_LINTL := $(shell \
  bash -c 'if echo -e "\#include <libintl.h>\nint main(int a, char** b) { gettext(\"\") ; return 0; }\n" | \
    $(HOSTCC) $(HOSTCFLAGS) -x c - -o /dev/null> /dev/null 2>&1 ; \
  then echo no ; \
  else echo yes ; fi')
ifeq ($(KBUILD_NEED_LINTL),yes)
  HOSTLOADLIBES_conf += -lintl
  HOSTLOADLIBES_mconf        += -lintl
endif

foo:
        echo ${HOSTLOADLIBES_mconf}
        echo ${HOSTLOADLIBES_conf}

Still bombs out.

However:

barbeque/zarathustra:linux-2.6: if echo -e '#include <libintl.h>
int main(int a, char** b)
{
gettext("");
return 0;
}
' | cc -x c - -o /dev/null > /dev/null 2>&1 ; then
> echo no
> else
> echo yes
> fi
no

So... anyone have an idea what's going on?

The shell output was under bash, with SHELL set to /bin/bash.

Debian amd64 port, using the stable tree:
barbeque/zarathustra:linux-2.6: make --version|head -1 ; gcc --version|head -1
GNU Make 3.80
gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)

-- DN
Daniel
