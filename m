Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269638AbRHQEWW>; Fri, 17 Aug 2001 00:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269633AbRHQEWO>; Fri, 17 Aug 2001 00:22:14 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:20362 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269638AbRHQEWH>; Fri, 17 Aug 2001 00:22:07 -0400
Date: Thu, 16 Aug 2001 21:22:20 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: gibbs@scsiguy.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch: remove DB dependence of linux-2.4.9/drives/scsi/aic7xxx/aicasm
Message-ID: <20010816212220.A7151@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	First of all, thanks for the quick reply, Justin.

>> = Adam Richter
>  = Justin Gibbs

>>       Currently, building Justin Gibbs's otherwise excellent
>>aic7xxx driver requires the Berkeley DB library, because the
>>aic7xxx assembler that is used in the build process uses db
>>basically just to implement associative arrays in memory.
>
>You don't need to use the assembler.  Compiled firmware is
>provided in every distrubution I've made, including the one
>in the 2.4.9 kernel.  The default is to *not* build the
>firmware.  Just make sure that you don't have this option
>inadvertantly turned on in your config and you should be happy.

	I understand, and that is helpful, but I want to build
everything from sources.

>A wise CS proff once said, "Smart programmers are lazy.  They
>re-use stuff rather than write it over and over again."  In this
>case, I was able to implement my symbol table in all of 5 mintues
>without the need to debug the code that implements its core.  It
>may seem like overkill, but it allowed me to focus on the important
>things, like making the assembler useful.  The assember dates from
>1995, which might explain why it uses the dbv1 interface.
>
>"If it ain't broke, don't fix it."

	That was probably a good use of your time, and those are
good reasons in the absense of arguments to the contrary.  However,
in this case, there are arguments to the contrary, so it is a question
of which arguments outweigh the others.  The arguments for accepting
a trival DB implementation (I'm not asking you to write it) are:

	1. It eliminates another dependence for doing a complete source build.

	2. It potentially eliminates a dependence on a GPL'ed library,
	   a policy preference of at least one Linux distribution that I
	   can think of (Debian), and probably a preference of some users.

	3. (New) it's a handy fallback in case somone finds a buggy
	   DB implementation.

	Anyhow, I've done it.  I have verified that the following
patch builds and produces the same aic7xxx_seq.h file, and produces
a aic7xxx_regs.h file that differs only in the order that the
"#define" statements are emitted (I checked by sorting both files and
seeing that the results were identical).  The new trivialdb.{c,h} files
compile under gcc-3.0 without complaint, even with "-Wall".

	I ask that you please include this patch, and/or tell Linus that
you think it's OK to apply.  If you don't like this patch, how about
using this patch, but with the "CONFIG_AICASM_TRIVALDB=y" line in
the Makefile commented out?  That will produce the old behavior but
allow use of trivialdb.{c,h} by just uncommenting one line.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aic.diffs"

--- linux-2.4.9/drivers/scsi/aic7xxx/aicasm/Makefile	Fri May  4 15:16:28 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/Makefile	Thu Aug 16 21:02:33 2001
@@ -5,10 +5,20 @@
 DEPHDRS= aicdb.h
 GENHDRS= y.tab.h aicdb.h
 
+# Comment out the next line to use your system's local Berkeley DB functions.
+CONFIG_AICASM_TRIVIALDB=y
+ifeq ($(CONFIG_AICASM_TRIVIALDB),y)
+	HAVE_TRIVIALDB=true
+	GENSRCS += trivialdb.c
+else
+	HAVE_TRIVIALDB=false
+	AICASM_DB=-ldb
+endif
+
 SRCS=	${GENSRCS} ${CSRCS}
 CLEANFILES= ${GENSRCS} ${GENHDRS} y.output
 # Override default kernel CFLAGS.  This is a userland app.
-AICASM_CFLAGS:= -I/usr/include -I. -ldb
+AICASM_CFLAGS:= -I/usr/include -I. $(AICASM_DB)
 YFLAGS= -d
 
 NOMAN=	noman
@@ -31,7 +41,9 @@
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG)
 
 aicdb.h:
-	@if [ -e "/usr/include/db3/db_185.h" ]; then		\
+	if $(HAVE_TRIVIALDB) ; then \
+		echo "#include \"trivialdb.h\"" > aicdb.h;	\
+	 elif [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db2/db_185.h" ]; then		\
 		echo "#include <db2/db_185.h>" > aicdb.h;	\
@@ -45,3 +57,4 @@
 
 clean:
 	rm -f $(CLEANFILES) $(PROG)
+
--- linux-2.4.9/drivers/scsi/aic7xxx/aicasm/trivialdb.h	Thu Aug 16 20:56:40 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/trivialdb.h	Thu Aug 16 21:05:38 2001
@@ -0,0 +1,64 @@
+/* A trivial implemention of the "BerkeleyDB" database routines
+   used by aicasm.
+
+   Copyright 2001 Yggdrasil Computing, Inc.
+   Written by Adam J. Richter <adam@yggdrasil.com>.
+
+   This file may be freely redistributed under the terms and conditions
+   of version 2 of the GNU General Public License, as publisehd by the
+   Free Software Foundation (Cambridge, Massachusetts).
+*/
+
+#ifndef TRIVIALDB_H
+#define TRIVIALDB_H
+
+typedef struct {
+	void *data;
+	int size;
+} DBT;
+
+enum seqtype {
+	R_FIRST=1,
+	R_NEXT,
+};
+
+enum db_result {
+	DB_SYSERROR=-1,
+	DB_OK=0,
+	DB_NOTFOUND=1,
+};
+
+enum db_opentype { DB_HASH };	/* not used */
+
+struct dbchain;			/* private */
+
+typedef struct DB {
+  	enum db_result (*get)(struct DB *db,
+			      DBT *key,
+			      DBT *data,
+			      int flags);
+
+  	enum db_result (*put)(struct DB *db,
+			      DBT *key,
+			      DBT *data,
+			      int flags);
+
+	void (*del)(struct DB *db,
+		    DBT *key,
+		    int flags /* ignored */);
+
+	enum db_result (*seq)(struct DB *db,
+			      DBT *key,
+			      DBT *data,
+			      enum seqtype order);
+
+	void (*close)(struct DB *db);
+	struct dbchain *chain;	/* private */
+	struct dbchain *seqnext; /* private */
+} DB;
+
+/* All parameters are ignored.  They are just for compatability. */
+extern DB *dbopen(const char *filename, int openflags, int mode,
+		  enum db_opentype type, void *openinfo);
+
+#endif /* TRIVIALDB_H */
--- linux-2.4.9/drivers/scsi/aic7xxx/aicasm/trivialdb.c	Thu Aug 16 20:56:40 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/trivialdb.c	Thu Aug 16 21:05:38 2001
@@ -0,0 +1,149 @@
+/* A trivial implemention of the "BerkeleyDB" database routines
+   used by aicasm.
+
+   Copyright 2001 Yggdrasil Computing, Inc.
+   Written by Adam J. Richter <adam@yggdrasil.com>.
+
+   This file may be freely redistributed under the terms and conditions
+   of version 2 of the GNU General Public License, as publisehd by the
+   Free Software Foundation (Cambridge, Massachusetts).
+*/
+
+#include <malloc.h>
+#include <string.h>
+
+#include "trivialdb.h"
+
+#define ASSERT(condition)	/* as nothing */
+
+static enum db_result trivget(struct DB *db, DBT *key, DBT *data, int flags);
+static enum db_result trivput(struct DB *db, DBT *key, DBT *data, int flags);
+static void trivdel(struct DB *db, DBT *key, int flags /* ignored */);
+static enum db_result trivseq(struct DB *db, DBT *key, DBT *data,
+			      enum seqtype order);
+static void trivclose(struct DB *db);
+
+static struct DB DB_template = {
+	get:	trivget,
+	put:	trivput,
+	del:	trivdel,
+	seq:	trivseq,
+	close:	trivclose,
+	chain:	NULL,
+	seqnext: NULL,
+};
+
+static void *
+memdup(void *ptr, int size)
+{
+	void *result;
+	if ((result = malloc(size)) != NULL) {
+		memcpy(result, ptr, size);
+	}
+	return result;
+}
+
+DB *
+dbopen(const char *filename, int openflags, int mode,
+       enum db_opentype type, void *openinfo) {
+	return memdup(&DB_template, sizeof(DB));
+}
+
+/* Routines above this line do not care about the structure of dbchain. */
+
+struct dbchain {
+	struct dbchain *next;
+	int keylen, datalen;
+	unsigned char key_data[0];
+};
+
+#define KEY(chain)	((chain)->key_data)
+#define DATA(chain)	((chain)->key_data + (chain)->keylen)
+
+static struct dbchain **
+find(struct dbchain **pChain, void *key, int keylen)
+{
+	while (*pChain != NULL &&
+	       ((*pChain)->keylen != keylen ||
+		memcmp(KEY(*pChain), key, keylen) != 0)) {
+
+		pChain = &(*pChain)->next;
+	}
+	return pChain;
+}
+
+static enum db_result
+copyout(DBT *dst, struct dbchain *src)
+{
+	void *copy;
+	if (src == NULL)
+		return DB_NOTFOUND;
+
+	if ((copy = memdup(DATA(src), src->datalen)) == NULL)
+		return DB_SYSERROR;
+
+	dst->size = src->datalen;
+	dst->data = copy;
+	return DB_OK;
+}
+
+static enum db_result
+trivget(struct DB *db, DBT *key, DBT *data, int flags)
+{
+	return copyout(data, *find(&db->chain, key->data, key->size));
+}
+
+static enum db_result
+trivput(struct DB *db, DBT *key, DBT *data, int flags)
+{
+	struct dbchain *chain;
+	chain = malloc(sizeof (struct dbchain) + key->size + data->size);
+	if (chain == NULL)
+		return DB_SYSERROR;
+
+	chain->keylen = key->size;
+	chain->datalen = data->size;
+	memcpy(KEY(chain), key->data, key->size);
+	memcpy(DATA(chain), data->data, data->size);
+	chain->next = db->chain;
+	db->chain = chain;
+	return DB_OK;
+}
+
+static void
+trivdel(struct DB *db, DBT *key, int flags /* ignored */)
+{
+	struct dbchain **pChain = find(&db->chain, key->data, key->size);
+	struct dbchain *chain = *pChain;
+
+	if (chain != NULL) {
+		*pChain = chain->next;
+		free(chain);
+	}
+}
+
+static enum db_result
+trivseq(struct DB *db, DBT *key, DBT *data, enum seqtype order)
+{
+	if (order == R_FIRST)
+		db->seqnext = db->chain;
+	else {
+		ASSERT(db->seqnext != NULL);
+		db->seqnext = db->seqnext->next;
+	}
+	return copyout(data, db->seqnext);
+}
+
+static void trivclose(struct DB *db) {
+	struct dbchain **pChain;
+
+	pChain = &db->chain;
+	for(;;) {
+		struct dbchain *chain = *pChain;
+		if (chain == NULL)
+			return;
+		pChain = &chain->next;
+		free(chain);
+	}
+}
+

--r5Pyd7+fXNt84Ff3--
