Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbUAUVZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUAUVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:25:48 -0500
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:51129 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S264142AbUAUVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:25:45 -0500
Subject: 2.4.23: user/kernel pointer bugs in drivers/pcmcia/ds.c
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: dhinds@zen.stanford.edu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Jan 2004 13:25:43 -0800
Message-Id: <1074720344.28494.1354.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there are several user/kernel pointer bugs in
drivers/pcmcia/ds.c:ds_ioctl().  I haven't made a patch because the
fixes aren't obvious (to me).  Here they are:

** ds.c:748   
    if (cmd & IOC_IN) copy_from_user((char *)&buf, (char *)arg, size);
    // The fields of buf are now under user control

** ds.c:809   
    pcmcia_get_first_window(&buf.win_info.handle, &buf.win_info.window);

** cs.c:1199
int pcmcia_get_first_window(window_handle_t *win, win_req_t *req)
{
    if ((win == NULL) || ((*win)->magic != WINDOW_MAGIC))
	return CS_BAD_HANDLE;
    return pcmcia_get_window(win, 0, req);
}

So *win is a pointer under user control, and ((*win)->magic derefs it.
I think it gets derefed again in pcmcia_get_window.  The call to
pcmcia_get_next_window() on ds.c:812 has the the same problem.



Similarly:

** ds.c:805
	ret = pcmcia_get_next_region(s->handle, &buf.region);

** bulkmem.c: 439
int pcmcia_get_next_region(client_handle_t handle, region_info_t *rgn)
{
    if (CHECK_HANDLE(handle))
	return CS_BAD_HANDLE;
    return match_region(handle, rgn->next, rgn);
} /* get_next_region */

The memory pointed to by rgn is under user control, so rgn->next
is under user control.

** bulkmem.c: 406
static int match_region(client_handle_t handle, memory_handle_t list,
			region_info_t *match)
{
    while (list != NULL) {
	if (!(handle->Attributes & INFO_MTD_CLIENT) ||
	    (strcmp(handle->dev_info, list->dev_info) == 0)) {
	    *match = list->info;
	    return CS_SUCCESS;
	}
	list = list->info.next;
    }
    return CS_NO_MORE_ITEMS;
} /* match_region */

So list is a pointer under user control, and strcmp(.., list->dev_info)
derefs it
(and list->info, etc.).

There are similar problems with the calls
pcmcia_get_first_region()    on ds.c:802,
pcmcia_get_mem_page()        on ds.c:815 (first argument)


Thanks for looking at these.

Best,
Rob

P.S. These bugs were found using the source code verification
tool, CQual, developed by Jeff Foster, myself, and others, and available
from http://www.cs.umd.edu/~jfoster/cqual/.


