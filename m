Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUD3WXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUD3WXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUD3WXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:23:51 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:33758 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261654AbUD3WXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:23:47 -0400
Date: Fri, 30 Apr 2004 15:23:00 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       <mc@cs.Stanford.EDU>, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] Return Error code gets treated as dir_table index, resulting
 losses of other dir entries (JFS2.4, kernel 2.4.19)
In-Reply-To: <1083353278.14140.52.camel@shaggy.austin.ibm.com>
Message-ID: <Pine.GSO.4.44.0404301521130.14155-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


static function add_index can fail by return -EPERM (and it is declared to
return a unsigned 4-byte integer).  This error gets ignored by the caller,
dtInsertEntry, which will treat the returned error code (u32)(-EPERM) as
an index to dir_table.  This causes losses of directory entries in the
same parent directory.

static u32 add_index(tid_t tid, struct inode *ip, s64 bn, int slot)
{
...
		if ((mp = get_index_page(ip, 0)) == 0) {
			jfs_err("add_index: get_metapage failed!");
			xtTruncate(tid, ip, 0, COMMIT_PWMAP);
Return -->		return -EPERM;
...
}


static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
			  ddata_t * data, struct dt_lock ** dtlock)
{
...
Error -->		  lh->index = cpu_to_le32(add_index(data->leaf.tid,
							  data->leaf.ip,
							  bn, index));
...
}


Here is a trace:

============ Filesystem Image Before System Call ===================
4 files, 1 dirs, 6 nodes
[0:D]
  [1:F:1073741824]
  [2:F:0]
  [3:F:0]
  [4:D]

create file 5 succeeded.
can't get dir entry Input/output error
ERROR: Filesystem images differ

============= Filesystem Image After System Call ===================
3 files, 0 dirs, 4 nodes
[0:D]
  [1:F:1073741824]
  [2:F:0]
  [3:F:0]

