Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWBAMsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWBAMsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWBAMsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:48:36 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:48795 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030233AbWBAMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:48:35 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Wed, 1 Feb 2006 22:45:01 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060201113711.6320.42205.stgit@localhost.localdomain> <84144f020602010432p51ff7a9cq1dd6654bd04f36a4@mail.gmail.com>
In-Reply-To: <84144f020602010432p51ff7a9cq1dd6654bd04f36a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2182137.n4Si1xY6JI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602012245.06328.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2182137.n4Si1xY6JI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 01 February 2006 22:32, Pekka Enberg wrote:
> On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > Suspend2 uses a strong internal API to separate the method of determini=
ng
> > the content of the image from the method by which it is saved. The code
> > for determining the content is part of the core of Suspend2, and
> > transformations (compression and/or encryption) and storage of the pages
> > are handled by 'modules'.
>
> [snip]
>
> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> >
> >  0 files changed, 0 insertions(+), 0 deletions(-)
>
> Uh, oh, where's the patch?

Indeed! Oops! I think I've managed to put this in kmail without having it m=
angled!

Nigel


[Suspend2] kernel/power/modules.h

Suspend2 uses a strong internal API to separate the method of determining
the content of the image from the method by which it is saved. The code for
determining the content is part of the core of Suspend2, and
transformations (compression and/or encryption) and storage of the pages
are handled by 'modules'.

The name is currently mostly historical, from the time when these
components could be built as kernel modules. That function was dropped to
help with merging, but I'd like to reintroduce it later, since some
embedded developers want to use Suspend2 to improve boot times. If/when
that happens, I'll do it in a way that doesn't require as many exported
symbols as was previously required. For now, though, the name remains,
along with a few functions that are needed for building as modules. My
expectation is that merging will take some time; perhaps by that time, I'll
have modular support back in, in a better form.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

=2D--
commit a97697c4228b1f4daa0d692b373f3811bec9cb76
tree 8bf0c9e2bff6abe18ca410a14062a3e2ed8e4214
parent 424a2272be7e6858b3929bae5fbc645c35897482
author Nigel Cunningham <nigel@suspend2.net> Wed, 01 Feb 2006 22:37:48 +1000
committer root <nigel@suspend2.net> Wed, 01 Feb 2006 22:37:48 +1000

 kernel/power/modules.h |  179 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 179 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.h b/kernel/power/modules.h
new file mode 100644
index 0000000..ee34199
=2D-- /dev/null
+++ b/kernel/power/modules.h
@@ -0,0 +1,179 @@
+/*
+ * kernel/power/module.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations for modules. Plugins are additions to
+ * suspend2 that provide facilities such as image compression or
+ * encryption, backends for storage of the image and user interfaces.
+ *
+ */
+
+/* This is the maximum size we store in the image header for a module name=
 */
+#define SUSPEND_MAX_PLUGIN_NAME_LENGTH 30
+
+/* Per-module metadata */
+struct module_header {
+	char name[SUSPEND_MAX_PLUGIN_NAME_LENGTH];
+	int disabled;
+	int type;
+	int index;
+	int data_length;
+	unsigned long signature;
+};
+
+extern int num_modules, num_writers;
+
+enum {
+	FILTER_PLUGIN,
+	WRITER_PLUGIN,
+	MISC_PLUGIN, // Block writer, eg.
+	CHECKSUM_PLUGIN
+};
+
+enum {
+	SUSPEND_ASYNC,
+	SUSPEND_SYNC
+};
+
+struct suspend_filter_ops {
+	/* Writing the image proper */
+	int (*write_chunk) (struct page *buffer_page);
+
+	/* Reading the image proper */
+	int (*read_chunk) (struct page *buffer_page, int sync);
+
+	/* Reset module if image exists but reading aborted */
+	void (*noresume_reset) (void);
+	struct list_head filter_list;
+};
+
+struct suspend_writer_ops {
+=09
+	/* Writing the image proper */
+	int (*write_chunk) (struct page *buffer_page);
+
+	/* Reading the image proper */
+	int (*read_chunk) (struct page *buffer_page, int sync);
+
+	/* Reset module if image exists but reading aborted */
+	void (*noresume_reset) (void);
+
+	/* Calls for allocating storage */
+
+	int (*storage_available) (void); // Maximum size of image we can save
+					  // (incl. space already allocated).
+=09
+	int (*storage_allocated) (void);
+					// Amount of storage already allocated
+	int (*release_storage) (void);
+=09
+	/*=20
+	 * Header space is allocated separately. Note that allocation
+	 * of space for the header might result in allocated space=20
+	 * being stolen from the main pool if there is no unallocated
+	 * space. We have to be able to allocate enough space for
+	 * the header. We can eat memory to ensure there is enough
+	 * for the main pool.
+	 */
+	int (*allocate_header_space) (int space_requested);
+	int (*allocate_storage) (int space_requested);
+=09
+	/* Read and write the metadata */=09
+	int (*write_header_init) (void);
+	int (*write_header_chunk) (char *buffer_start, int buffer_size);
+	int (*write_header_cleanup) (void);
+
+	int (*read_header_init) (void);
+	int (*read_header_chunk) (char *buffer_start, int buffer_size);
+	int (*read_header_cleanup) (void);
+
+	/* Prepare metadata to be saved (relativise/absolutise extents) */
+	int (*serialise_extents) (void);
+	int (*load_extents) (void);
+=09
+	/* Attempt to parse an image location */
+	int (*parse_sig_location) (char *buffer, int only_writer);
+
+	/* Determine whether image exists that we can restore */
+	int (*image_exists) (void);
+=09
+	/* Mark the image as having tried to resume */
+	void (*mark_resume_attempted) (void);
+
+	/* Destroy image if one exists */
+	int (*invalidate_image) (void);
+=09
+	/* Wait on I/O */
+	int (*wait_on_io) (int flush_all);
+
+	struct list_head writer_list;
+};
+
+struct suspend_module_ops {
+	/* Functions common to all modules */
+	int type;
+	char *name;
+	struct module *module;
+	int disabled;
+	struct list_head module_list;
+
+	/* Bytes! */
+	unsigned long (*memory_needed) (void);
+	unsigned long (*storage_needed) (void);
+
+	int (*print_debug_info) (char *buffer, int size);
+	int (*save_config_info) (char *buffer);
+	void (*load_config_info) (char *buffer, int len);
+=09
+	/* Initialise & cleanup - general routines called
+	 * at the start and end of a cycle. */
+	int (*initialise) (int starting_cycle);
+	void (*cleanup) (int finishing_cycle);
+
+	int (*write_init) (int stream_number);
+	int (*write_cleanup) (void);
+
+	int (*read_init) (int stream_number);
+	int (*read_cleanup) (void);
+
+	union {
+		struct suspend_filter_ops filter;
+		struct suspend_writer_ops writer;
+	} ops;
+};
+
+extern struct suspend_module_ops *active_writer;
+extern struct list_head suspend_filters, suspend_writers, suspend_modules;
+
+extern void prepare_console_modules(void);
+extern void cleanup_console_modules(void);
+
+extern struct suspend_module_ops *find_module_given_name(char *name);
+extern struct suspend_module_ops *get_next_filter(struct suspend_module_op=
s *);
+
+extern int suspend_register_module(struct suspend_module_ops *module);
+extern void suspend_move_module_tail(struct suspend_module_ops *module);
+
+extern unsigned long header_storage_for_modules(void);
+extern unsigned long memory_for_modules(void);
+
+extern int print_module_debug_info(char *buffer, int buffer_size);
+extern int suspend_register_module(struct suspend_module_ops *module);
+extern void suspend_unregister_module(struct suspend_module_ops *module);
+
+extern int suspend2_initialise_modules(int starting_cycle);
+extern void suspend2_cleanup_modules(int finishing_cycle);
+
+int suspend2_get_modules(void);
+void suspend2_put_modules(void);
+
+static inline void suspend_initialise_module_lists(void) {
+	INIT_LIST_HEAD(&suspend_filters);
+	INIT_LIST_HEAD(&suspend_writers);
+	INIT_LIST_HEAD(&suspend_modules);
+}
+
+extern int expected_compression_ratio(void);


=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2182137.n4Si1xY6JI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4K1SN0y+n1M3mo0RAtCJAKCSypReRXdUbm1HP4px2HL9R7YxwgCgiKh1
urKZqP/HDa71aiQLKfX8gY0=
=bO6d
-----END PGP SIGNATURE-----

--nextPart2182137.n4Si1xY6JI--
