Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVGMV67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVGMV67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVGMV5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:57:24 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61411 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262652AbVGMVzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:55:40 -0400
Subject: Re: supporting functions missing from inotify patch
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: rml@novell.com
In-Reply-To: <1121286081.5555.73.camel@stevef95.austin.ibm.com>
References: <1121286081.5555.73.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1121291505.5555.92.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Jul 2005 16:51:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is dir_notify suitable for inotify and your uses?
The six dir_notify flags obviously map better to the network protocol
which cifs can request (and which Samba server needs to respond to
various network filesystem clients) but the 11 IN_ flags do not seem
that different.

>The problem with dir_notify is that the args parameter is 
> dnotify flags. Those don't map directly to inotify flags.

They almost map (11 down to 6) -  Not sure how 
	IN_MOVE_FROM and IN_MOVE_TO
map to DN_RENAME or what DNOTIFY event delete self triggerred (inotify
splits IN_DELETE_SELF out).

The mapping of the local calls to the network filesystem wire protocol
also will be interesting.

The corresponding network filesystem protocol defines a few events that
don't make sense to Linux (changing dos attributes for a file e.g.) but
I don't think that that matters much.  More important is whether it can
handle the IN_ events 

[from fs/cifs/cifspdu.h]
/* Completion Filter flags for Notify */
#define FILE_NOTIFY_CHANGE_FILE_NAME    0x00000001
#define FILE_NOTIFY_CHANGE_DIR_NAME     0x00000002
#define FILE_NOTIFY_CHANGE_NAME         0x00000003
#define FILE_NOTIFY_CHANGE_ATTRIBUTES   0x00000004
#define FILE_NOTIFY_CHANGE_SIZE         0x00000008
#define FILE_NOTIFY_CHANGE_LAST_WRITE   0x00000010
#define FILE_NOTIFY_CHANGE_LAST_ACCESS  0x00000020
#define FILE_NOTIFY_CHANGE_CREATION     0x00000040
#define FILE_NOTIFY_CHANGE_EA           0x00000080
#define FILE_NOTIFY_CHANGE_SECURITY     0x00000100
#define FILE_NOTIFY_CHANGE_STREAM_NAME  0x00000200
#define FILE_NOTIFY_CHANGE_STREAM_SIZE  0x00000400
#define FILE_NOTIFY_CHANGE_STREAM_WRITE 0x00000800

Which can cause the server to report back "actions" in the notification
events sent to the client:
#define FILE_ACTION_ADDED               0x00000001
#define FILE_ACTION_REMOVED             0x00000002
#define FILE_ACTION_MODIFIED            0x00000003
#define FILE_ACTION_RENAMED_OLD_NAME    0x00000004
#define FILE_ACTION_RENAMED_NEW_NAME    0x00000005
#define FILE_ACTION_ADDED_STREAM        0x00000006
#define FILE_ACTION_REMOVED_STREAM      0x00000007
#define FILE_ACTION_MODIFIED_STREAM     0x00000008

I don't see a way to do mapping of IN_OPEN, IN_CLOSE_WRITE and IN_CLOSE_NOWRITE
to anything that makes sense to the server but the rest may be doable.


