Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270164AbTGUPLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270165AbTGUPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:11:54 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:47233 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S270164AbTGUPLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:11:52 -0400
Date: Mon, 21 Jul 2003 17:26:46 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.org
Subject: How is info->cmap supposed to work?
Message-ID: <20030721152646.GA14520@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
  I have few problems with understanding how
info->cmap is supposed to work:

(1) FBIOGETCMAP calls fb_copy_cmap(&info->cmap, &cmap, 0);
    Should not it use last argument of '2', as &cmap points
    to the userspace? It looks to me like that anybody can
    overwrite kernel currently... Only positive side is that
    there is no way to control info->cmap contents (see (2)),
    so you can only crash kernel with random code, you cannot 
    stuff some malicious code there.

(2) FBIOPUTCMAP calls fb_set_cmap, which in turn calls
    fb_setcolreg. FBIOGETCMAP copies cmap entries from
    info->cmap (after fixing (1)). Does it mean that
    fb_setcolreg has to fill info->cmap itself? Is not it
    a bit ugly? And fb_set_cmap documentation is incorrect:
    kspc == 0 means copy from userspace, while
    kspc != 0 means copy "local", inside kernel-space. Documentation
    says that 0 is local, while 1 is get_user.

(3) And who is supposed to initialize info->cmap, and to
    what value? It looks to me like that fbdev driver is
    supposed to do:

      memset(&info->cmap, 0, sizeof(info->cmap));
      fb_alloc_cmap(&info->cmap, 256, 1);

    Is it right? What about fb_init_cmap() then? And why
    fbdev has to play with info->cmap, cannot generic
    layer take a care of this, if all info->cmap accesses
    go through generic layer, and fbdev driver itself has
    no need for this field?

    				Thanks,
    					Petr Vandrovec
    					vandrove@vc.cvut.cz

