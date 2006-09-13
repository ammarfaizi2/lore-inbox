Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWIMClV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWIMClV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 22:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWIMClV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 22:41:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:40683 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751514AbWIMClT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 22:41:19 -0400
Date: Tue, 12 Sep 2006 21:41:16 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eCryptfs: Versioning fixes
Message-ID: <20060913024116.GB13859@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs userspace utilities need to be able to detect what is and is
not supported by the kernel module. This patch cleans up the auth_tok
data structure that is shared between kernel and userspace via the
kernel keyring, reserving some space for future struct components that
will be needed as eCryptfs gains more features. It also introduces
some sysfs handles that the userspace utilities query to determine how
the tools should behave. These changes will help ensure that, from
this point forward, any version of the kernel module will properly
work with any version of the userspace tools without any need to
recompile code.

All userspace utility packages (available from the SourceForge site as
detailed in Documents/ecryptfs.txt) before ecryptfs-util-1.tar.bz2 are
incompatible with the changes made in this patch. Future versions of
the userspace utilities will no longer reference kernel version
numbers, but they will rather detect capabilities supported based on
the sysfs version handle.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/debug.c           |    7 --
 fs/ecryptfs/ecryptfs_kernel.h |   26 ++++--
 fs/ecryptfs/keystore.c        |    9 +-
 fs/ecryptfs/main.c            |  172 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 178 insertions(+), 36 deletions(-)

8bcdd6b086d025a86ef5573bb8ceaa6f12c8ad95
diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 2261945..61f8e89 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -55,13 +55,6 @@ void ecryptfs_dump_auth_tok(struct ecryp
 		sig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
 		ecryptfs_printk(KERN_DEBUG, " * signature = [%s]\n", sig);
 	}
-	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_CONTAINS_SECRET)) {
-		ecryptfs_printk(KERN_DEBUG, " * contains secret value\n");
-	} else {
-		ecryptfs_printk(KERN_DEBUG, " * lacks secret value\n");
-	}
-	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_EXPIRED))
-		ecryptfs_printk(KERN_DEBUG, " * expired\n");
 	ecryptfs_printk(KERN_DEBUG, " * session_key.flags = [0x%x]\n",
 			auth_tok->session_key.flags);
 	if (auth_tok->session_key.flags
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 2b7ae27..4cfba7d 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -32,8 +32,17 @@ #include <linux/scatterlist.h>
 
 /* Version verification for shared data structures w/ userspace */
 #define ECRYPTFS_VERSION_MAJOR 0x00
-#define ECRYPTFS_VERSION_MINOR 0x02
+#define ECRYPTFS_VERSION_MINOR 0x04
 #define ECRYPTFS_SUPPORTED_FILE_VERSION 0x01
+/* These flags indicate which features are supported by the kernel
+ * module; userspace tools such as the mount helper read
+ * ECRYPTFS_VERSIONING_MASK from a sysfs handle in order to determine
+ * how to behave. */
+#define ECRYPTFS_VERSIONING_PASSPHRASE 0x00000001
+#define ECRYPTFS_VERSIONING_PUBKEY 0x00000002
+#define ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH 0x00000004
+#define ECRYPTFS_VERSIONING_POLICY 0x00000008
+#define ECRYPTFS_VERSIONING_MASK (ECRYPTFS_VERSIONING_PASSPHRASE)
 
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
 #define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
@@ -100,23 +109,20 @@ #define ECRYPTFS_SESSION_KEY_ENCRYPTION_
 	u8 salt[ECRYPTFS_SALT_SIZE];
 };
 
+enum ecryptfs_token_types {ECRYPTFS_PASSWORD, ECRYPTFS_PRIVATE_KEY};
+
 /* May be a password or a private key */
 struct ecryptfs_auth_tok {
 	u16 version; /* 8-bit major and 8-bit minor */
-#define ECRYPTFS_PASSWORD         0x00000001
-#define ECRYPTFS_PRIVATE_KEY      0x00000002
-#define ECRYPTFS_CONTAINS_SECRET  0x00000004
-#define ECRYPTFS_EXPIRED          0x00000008
+	u16 token_type;
 	u32 flags;
-	uid_t uid;
-	u64 creation_time;
-	u64 expiration_time;
+	struct ecryptfs_session_key session_key;
+	u8 reserved[32];
 	union {
 		struct ecryptfs_password password;
 		/* Private key is in future eCryptfs releases */
 	} token;
-	struct ecryptfs_session_key session_key;
-};
+} __attribute__ ((packed));
 
 void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok);
 extern void ecryptfs_to_hex(char *dst, char *src, size_t src_size);
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 35ba927..ba45478 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -318,9 +318,7 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		rc = -ENOSYS;
 		goto out_free;
 	}
-	/* TODO: Use the keyring */
-	(*new_auth_tok)->uid = current->uid;
-	ECRYPTFS_SET_FLAG((*new_auth_tok)->flags, ECRYPTFS_PASSWORD);
+	(*new_auth_tok)->token_type = ECRYPTFS_PASSWORD;
 	/* TODO: Parametarize; we might actually want userspace to
 	 * decrypt the session key. */
 	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
@@ -688,8 +686,7 @@ int ecryptfs_parse_packet_set(struct ecr
 			ecryptfs_dump_auth_tok(candidate_auth_tok);
 		}
 		/* TODO: Replace ECRYPTFS_SIG_SIZE_HEX w/ dynamic value */
-		if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
-					 ECRYPTFS_PASSWORD))
+		if (candidate_auth_tok->token_type == ECRYPTFS_PASSWORD
 		    && !strncmp(candidate_auth_tok->token.password.signature,
 				sig, ECRYPTFS_SIG_SIZE_HEX)) {
 			found_auth_tok = 1;
@@ -1013,7 +1010,7 @@ ecryptfs_generate_key_packet_set(char *d
 	(*len) = 0;
 	if (mount_crypt_stat->global_auth_tok) {
 		auth_tok = mount_crypt_stat->global_auth_tok;
-		if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PASSWORD)) {
+		if (auth_tok->token_type == ECRYPTFS_PASSWORD) {
 			rc = write_tag_3_packet((dest_base + (*len)),
 						max, auth_tok,
 						crypt_stat, &key_rec,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index ecf9faf..93c860d 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -351,7 +351,7 @@ static int ecryptfs_parse_options(struct
 		rc = -EINVAL;
 		goto out;
 	}
-	if (!ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PASSWORD)) {
+	if (auth_tok->token_type != ECRYPTFS_PASSWORD) {
 		ecryptfs_printk(KERN_ERR, "Invalid auth_tok structure "
 				"returned from key\n");
 		rc = -EINVAL;
@@ -604,6 +604,19 @@ static struct ecryptfs_cache_info {
 	},
 };
 
+static void ecryptfs_free_kmem_caches(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ecryptfs_cache_infos); i++) {
+		struct ecryptfs_cache_info *info;
+
+		info = &ecryptfs_cache_infos[i];
+		if (*(info->cache))
+			kmem_cache_destroy(*(info->cache));
+	}
+}
+
 /**
  * ecryptfs_init_kmem_caches
  *
@@ -620,6 +633,7 @@ static int ecryptfs_init_kmem_caches(voi
 		*(info->cache) = kmem_cache_create(info->name, info->size,
 				0, SLAB_HWCACHE_ALIGN, info->ctor, NULL);
 		if (!*(info->cache)) {
+			ecryptfs_free_kmem_caches();
 			ecryptfs_printk(KERN_WARNING, "%s: "
 					"kmem_cache_create failed\n",
 					info->name);
@@ -629,20 +643,130 @@ static int ecryptfs_init_kmem_caches(voi
 	return 0;
 }
 
-static void ecryptfs_free_kmem_caches(void)
+struct ecryptfs_obj {
+	char *name;
+	struct list_head slot_list;
+	struct kobject kobj;
+};
+
+struct ecryptfs_attribute {
+	struct attribute attr;
+	ssize_t(*show) (struct ecryptfs_obj *, char *);
+	ssize_t(*store) (struct ecryptfs_obj *, const char *, size_t);
+};
+
+static ssize_t
+ecryptfs_attr_store(struct kobject *kobj,
+		    struct attribute *attr, const char *buf, size_t len)
+{
+	struct ecryptfs_obj *obj = container_of(kobj, struct ecryptfs_obj,
+						kobj);
+	struct ecryptfs_attribute *attribute =
+		container_of(attr, struct ecryptfs_attribute, attr);
+
+	return (attribute->store ? attribute->store(obj, buf, len) : 0);
+}
+
+static ssize_t
+ecryptfs_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct ecryptfs_obj *obj = container_of(kobj, struct ecryptfs_obj,
+						kobj);
+	struct ecryptfs_attribute *attribute =
+		container_of(attr, struct ecryptfs_attribute, attr);
+
+	return (attribute->show ? attribute->show(obj, buf) : 0);
+}
+
+static struct sysfs_ops ecryptfs_sysfs_ops = {
+	.show = ecryptfs_attr_show,
+	.store = ecryptfs_attr_store
+};
+
+static struct kobj_type ecryptfs_ktype = {
+	.sysfs_ops = &ecryptfs_sysfs_ops
+};
+
+decl_subsys(ecryptfs, &ecryptfs_ktype, NULL);
+
+static ssize_t version_show(struct ecryptfs_obj *obj, char *buff)
+{
+	return snprintf(buff, PAGE_SIZE, "%d\n", ECRYPTFS_VERSIONING_MASK);
+}
+
+static struct ecryptfs_attribute sysfs_attr_version = __ATTR_RO(version);
+
+struct ecryptfs_version_str_map_elem {
+	u32 flag;
+	char *str;
+} ecryptfs_version_str_map[] = {
+	{ECRYPTFS_VERSIONING_PASSPHRASE, "passphrase"},
+	{ECRYPTFS_VERSIONING_PUBKEY, "pubkey"},
+	{ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH, "plaintext passthrough"},
+	{ECRYPTFS_VERSIONING_POLICY, "policy"}
+};
+
+static ssize_t version_str_show(struct ecryptfs_obj *obj, char *buff)
 {
 	int i;
+	int remaining = PAGE_SIZE;
+	int total_written = 0;
 
-	for (i = 0; i < ARRAY_SIZE(ecryptfs_cache_infos); i++) {
-		struct ecryptfs_cache_info *info;
+	buff[0] = '\0';
+	for (i = 0; i < ARRAY_SIZE(ecryptfs_version_str_map); i++) {
+		int entry_size;
 
-		info = &ecryptfs_cache_infos[i];
-		if (*(info->cache))
-			kmem_cache_destroy(*(info->cache));
+		if (!(ECRYPTFS_VERSIONING_MASK
+		      & ecryptfs_version_str_map[i].flag))
+			continue;
+		entry_size = strlen(ecryptfs_version_str_map[i].str);
+		if ((entry_size + 2) > remaining)
+			goto out;
+		memcpy(buff, ecryptfs_version_str_map[i].str, entry_size);
+		buff[entry_size++] = '\n';
+		buff[entry_size] = '\0';
+		buff += entry_size;
+		total_written += entry_size;
+		remaining -= entry_size;
+	}
+out:
+	return total_written;
+}
+
+static struct ecryptfs_attribute sysfs_attr_version_str = __ATTR_RO(version_str);
+
+static int do_sysfs_registration(void)
+{
+	int rc;
+
+	if ((rc = subsystem_register(&ecryptfs_subsys))) {
+		printk(KERN_ERR
+		       "Unable to register ecryptfs sysfs subsystem\n");
+		goto out;
 	}
+	rc = sysfs_create_file(&ecryptfs_subsys.kset.kobj,
+			       &sysfs_attr_version.attr);
+	if (rc) {
+		printk(KERN_ERR
+		       "Unable to create ecryptfs version attribute\n");
+		subsystem_unregister(&ecryptfs_subsys);
+		goto out;
+	}
+	rc = sysfs_create_file(&ecryptfs_subsys.kset.kobj,
+			       &sysfs_attr_version_str.attr);
+	if (rc) {
+		printk(KERN_ERR
+		       "Unable to create ecryptfs version_str attribute\n");
+		sysfs_remove_file(&ecryptfs_subsys.kset.kobj,
+				  &sysfs_attr_version.attr);
+		subsystem_unregister(&ecryptfs_subsys);
+		goto out;
+	}
+out:
+	return rc;
 }
 
-static int __init init_ecryptfs_fs(void)
+static int __init ecryptfs_init(void)
 {
 	int rc;
 
@@ -657,16 +781,38 @@ static int __init init_ecryptfs_fs(void)
 		goto out;
 	}
 	rc = ecryptfs_init_kmem_caches();
-	if (rc)
+	if (rc) {
+		printk(KERN_ERR
+		       "Failed to allocate one or more kmem_cache objects\n");
 		goto out;
-	ecryptfs_printk(KERN_DEBUG, "Registering eCryptfs\n");
+	}
 	rc = register_filesystem(&ecryptfs_fs_type);
+	if (rc) {
+		printk(KERN_ERR "Failed to register filesystem\n");
+		ecryptfs_free_kmem_caches();
+		goto out;
+	}
+	kset_set_kset_s(&ecryptfs_subsys, fs_subsys);
+	sysfs_attr_version.attr.owner = THIS_MODULE;
+	sysfs_attr_version_str.attr.owner = THIS_MODULE;
+	rc = do_sysfs_registration();
+	if (rc) {
+		printk(KERN_ERR "sysfs registration failed\n");
+		unregister_filesystem(&ecryptfs_fs_type);
+		ecryptfs_free_kmem_caches();
+		goto out;
+	}
 out:
 	return rc;
 }
 
-static void __exit exit_ecryptfs_fs(void)
+static void __exit ecryptfs_exit(void)
 {
+	sysfs_remove_file(&ecryptfs_subsys.kset.kobj,
+			  &sysfs_attr_version.attr);
+	sysfs_remove_file(&ecryptfs_subsys.kset.kobj,
+			  &sysfs_attr_version_str.attr);
+	subsystem_unregister(&ecryptfs_subsys);
 	unregister_filesystem(&ecryptfs_fs_type);
 	ecryptfs_free_kmem_caches();
 }
@@ -676,5 +822,5 @@ MODULE_DESCRIPTION("eCryptfs");
 
 MODULE_LICENSE("GPL");
 
-module_init(init_ecryptfs_fs)
-module_exit(exit_ecryptfs_fs)
+module_init(ecryptfs_init)
+module_exit(ecryptfs_exit)
-- 
1.3.3

