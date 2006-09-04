Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWIDXR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWIDXR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWIDXQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:16:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:29901 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932243AbWIDXQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:16:00 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:53 +1000
Message-Id: <1060904231553.23124@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 9] knfsd: nfsd4: acls: relax the nfsv4->posix mapping
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Use a different nfsv4->(draft posix) acl mapping which is
	1. completely backwards compatible,
	2. accepts any nfsv4 acl, and
	3. errs on the side of restricting permissions.

In detail:

	1. completely backwards compatible: The new mapping produces the
	same result on any acl produced by the existing (draft
	posix)->nfsv4 mapping; the one exception is that we no longer
	attempt to guess the value of the mask by assuming certain denies
	represent the mask.  Since the server still keeps track of the mask
	locally, sequences of chmod's will still be handled fine; the only
	thing this will change is sequences of chmod's with intervening
	read-modify-writes of the acl.  That last case just isn't worth the
	trouble and the possible misrepresentations of the user's intent
	(if we guess that a certain deny indicates masking is in effect
	when it really isn't).

	2. accepts any nfsv4 acl: That's not quite true: we still reject
	acls that use combinations of inheritance flags that we don't
	support.  We also reject acls that attempt to explicitly deny
	read_acl or read_attributes permissions, or that attempt to deny
	write_acl or write_attributes permissions to the owner of the file.

	3.  errs on the side of restricting permissions: one exception to
	this last rule: we totally ignore some bits (write_owner,
	synchronize, read_named_attributes, etc.) that are completely alien
	to our filesystem semantics, in some cases even if that would mean
	ignoring an explicit deny that we have no intention of enforcing.
	Excepting that, the posix acl produced should be the most
	permissive acl that is not more permissive than the given nfsv4
	acl.

And the new code's shorter, too.  Neato.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4acl.c |  639 ++++++++++++++++++++++------------------------------
 1 file changed, 279 insertions(+), 360 deletions(-)

diff .prev/fs/nfsd/nfs4acl.c ./fs/nfsd/nfs4acl.c
--- .prev/fs/nfsd/nfs4acl.c	2006-09-04 17:09:48.000000000 +1000
+++ ./fs/nfsd/nfs4acl.c	2006-09-04 17:20:49.000000000 +1000
@@ -96,24 +96,26 @@ deny_mask(u32 allow_mask, unsigned int f
 /* XXX: modify functions to return NFS errors; they're only ever
  * used by nfs code, after all.... */
 
-static int
-mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
+/* We only map from NFSv4 to POSIX ACLs when setting ACLs, when we err on the
+ * side of being more restrictive, so the mode bit mapping below is
+ * pessimistic.  An optimistic version would be needed to handle DENY's,
+ * but we espect to coalesce all ALLOWs and DENYs before mapping to mode
+ * bits. */
+
+static void
+low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
 {
-	u32 ignore = 0;
+	u32 write_mode = NFS4_WRITE_MODE;
 
-	if (!(flags & NFS4_ACL_DIR))
-		ignore |= NFS4_ACE_DELETE_CHILD; /* ignore it */
-	perm |= ignore;
+	if (flags & NFS4_ACL_DIR)
+		write_mode |= NFS4_ACE_DELETE_CHILD;
 	*mode = 0;
 	if ((perm & NFS4_READ_MODE) == NFS4_READ_MODE)
 		*mode |= ACL_READ;
-	if ((perm & NFS4_WRITE_MODE) == NFS4_WRITE_MODE)
+	if ((perm & write_mode) == write_mode)
 		*mode |= ACL_WRITE;
 	if ((perm & NFS4_EXECUTE_MODE) == NFS4_EXECUTE_MODE)
 		*mode |= ACL_EXECUTE;
-	if (!MASK_EQUAL(perm, ignore|mask_from_posix(*mode, flags)))
-		return -EINVAL;
-	return 0;
 }
 
 struct ace_container {
@@ -338,38 +340,6 @@ sort_pacl(struct posix_acl *pacl)
 	return;
 }
 
-static int
-write_pace(struct nfs4_ace *ace, struct posix_acl *pacl,
-		struct posix_acl_entry **pace, short tag, unsigned int flags)
-{
-	struct posix_acl_entry *this = *pace;
-
-	if (*pace == pacl->a_entries + pacl->a_count)
-		return -EINVAL; /* fell off the end */
-	(*pace)++;
-	this->e_tag = tag;
-	if (tag == ACL_USER_OBJ)
-		flags |= NFS4_ACL_OWNER;
-	if (mode_from_nfs4(ace->access_mask, &this->e_perm, flags))
-		return -EINVAL;
-	this->e_id = (tag == ACL_USER || tag == ACL_GROUP ?
-			ace->who : ACL_UNDEFINED_ID);
-	return 0;
-}
-
-static struct nfs4_ace *
-get_next_v4_ace(struct list_head **p, struct list_head *head)
-{
-	struct nfs4_ace *ace;
-
-	*p = (*p)->next;
-	if (*p == head)
-		return NULL;
-	ace = list_entry(*p, struct nfs4_ace, l_ace);
-
-	return ace;
-}
-
 int
 nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl, struct posix_acl **pacl,
 		struct posix_acl **dpacl, unsigned int flags)
@@ -429,349 +399,311 @@ out:
 	return error;
 }
 
-static int
-same_who(struct nfs4_ace *a, struct nfs4_ace *b)
-{
-	return a->whotype == b->whotype &&
-		(a->whotype != NFS4_ACL_WHO_NAMED || a->who == b->who);
-}
-
-static int
-complementary_ace_pair(struct nfs4_ace *allow, struct nfs4_ace *deny,
-		unsigned int flags)
-{
-	int ignore = 0;
-	if (!(flags & NFS4_ACL_DIR))
-		ignore |= NFS4_ACE_DELETE_CHILD;
-	return MASK_EQUAL(ignore|deny_mask(allow->access_mask, flags),
-			  ignore|deny->access_mask) &&
-		allow->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
-		deny->type == NFS4_ACE_ACCESS_DENIED_ACE_TYPE &&
-		allow->flag == deny->flag &&
-		same_who(allow, deny);
-}
-
-static inline int
-user_obj_from_v4(struct nfs4_acl *n4acl, struct list_head **p,
-		struct posix_acl *pacl, struct posix_acl_entry **pace,
-		unsigned int flags)
-{
-	int error = -EINVAL;
-	struct nfs4_ace *ace, *ace2;
+/*
+ * While processing the NFSv4 ACE, this maintains bitmasks representing
+ * which permission bits have been allowed and which denied to a given
+ * entity: */
+struct posix_ace_state {
+	u32 allow;
+	u32 deny;
+};
 
-	ace = get_next_v4_ace(p, &n4acl->ace_head);
-	if (ace == NULL)
-		goto out;
-	if (ace2type(ace) != ACL_USER_OBJ)
-		goto out;
-	error = write_pace(ace, pacl, pace, ACL_USER_OBJ, flags);
-	if (error < 0)
-		goto out;
-	error = -EINVAL;
-	ace2 = get_next_v4_ace(p, &n4acl->ace_head);
-	if (ace2 == NULL)
-		goto out;
-	if (!complementary_ace_pair(ace, ace2, flags))
-		goto out;
-	error = 0;
-out:
-	return error;
-}
+struct posix_user_ace_state {
+	uid_t uid;
+	struct posix_ace_state perms;
+};
 
-static inline int
-users_from_v4(struct nfs4_acl *n4acl, struct list_head **p,
-		struct nfs4_ace **mask_ace,
-		struct posix_acl *pacl, struct posix_acl_entry **pace,
-		unsigned int flags)
-{
-	int error = -EINVAL;
-	struct nfs4_ace *ace, *ace2;
+struct posix_ace_state_array {
+	int n;
+	struct posix_user_ace_state aces[];
+};
 
-	ace = get_next_v4_ace(p, &n4acl->ace_head);
-	if (ace == NULL)
-		goto out;
-	while (ace2type(ace) == ACL_USER) {
-		if (ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
-			goto out;
-		if (*mask_ace &&
-			!MASK_EQUAL(ace->access_mask, (*mask_ace)->access_mask))
-			goto out;
-		*mask_ace = ace;
-		ace = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace == NULL)
-			goto out;
-		if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE)
-			goto out;
-		error = write_pace(ace, pacl, pace, ACL_USER, flags);
-		if (error < 0)
-			goto out;
-		error = -EINVAL;
-		ace2 = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace2 == NULL)
-			goto out;
-		if (!complementary_ace_pair(ace, ace2, flags))
-			goto out;
-		if ((*mask_ace)->flag != ace2->flag ||
-				!same_who(*mask_ace, ace2))
-			goto out;
-		ace = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace == NULL)
-			goto out;
-	}
-	error = 0;
-out:
-	return error;
-}
+/*
+ * While processing the NFSv4 ACE, this maintains the partial permissions
+ * calculated so far: */
+
+struct posix_acl_state {
+	struct posix_ace_state owner;
+	struct posix_ace_state group;
+	struct posix_ace_state other;
+	struct posix_ace_state everyone;
+	struct posix_ace_state mask; /* Deny unused in this case */
+	struct posix_ace_state_array *users;
+	struct posix_ace_state_array *groups;
+};
 
-static inline int
-group_obj_and_groups_from_v4(struct nfs4_acl *n4acl, struct list_head **p,
-		struct nfs4_ace **mask_ace,
-		struct posix_acl *pacl, struct posix_acl_entry **pace,
-		unsigned int flags)
+static int
+init_state(struct posix_acl_state *state, int cnt)
 {
-	int error = -EINVAL;
-	struct nfs4_ace *ace, *ace2;
-	struct ace_container *ac;
-	struct list_head group_l;
-
-	INIT_LIST_HEAD(&group_l);
-	ace = list_entry(*p, struct nfs4_ace, l_ace);
-
-	/* group owner (mask and allow aces) */
-
-	if (pacl->a_count != 3) {
-		/* then the group owner should be preceded by mask */
-		if (ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
-			goto out;
-		if (*mask_ace &&
-			!MASK_EQUAL(ace->access_mask, (*mask_ace)->access_mask))
-			goto out;
-		*mask_ace = ace;
-		ace = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace == NULL)
-			goto out;
+	int alloc;
 
-		if ((*mask_ace)->flag != ace->flag || !same_who(*mask_ace, ace))
-			goto out;
+	memset(state, 0, sizeof(struct posix_acl_state));
+	/*
+	 * In the worst case, each individual acl could be for a distinct
+	 * named user or group, but we don't no which, so we allocate
+	 * enough space for either:
+	 */
+	alloc = sizeof(struct posix_ace_state_array)
+		+ cnt*sizeof(struct posix_ace_state);
+	state->users = kzalloc(alloc, GFP_KERNEL);
+	if (!state->users)
+		return -ENOMEM;
+	state->groups = kzalloc(alloc, GFP_KERNEL);
+	if (!state->groups) {
+		kfree(state->users);
+		return -ENOMEM;
 	}
+	return 0;
+}
 
-	if (ace2type(ace) != ACL_GROUP_OBJ)
-		goto out;
-
-	ac = kmalloc(sizeof(*ac), GFP_KERNEL);
-	error = -ENOMEM;
-	if (ac == NULL)
-		goto out;
-	ac->ace = ace;
-	list_add_tail(&ac->ace_l, &group_l);
-
-	error = -EINVAL;
-	if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE)
-		goto out;
-
-	error = write_pace(ace, pacl, pace, ACL_GROUP_OBJ, flags);
-	if (error < 0)
-		goto out;
-
-	error = -EINVAL;
-	ace = get_next_v4_ace(p, &n4acl->ace_head);
-	if (ace == NULL)
-		goto out;
+static void
+free_state(struct posix_acl_state *state) {
+	kfree(state->users);
+	kfree(state->groups);
+}
+
+static inline void add_to_mask(struct posix_acl_state *state, struct posix_ace_state *astate)
+{
+	state->mask.allow |= astate->allow;
+}
+
+/*
+ * Certain bits (SYNCHRONIZE, DELETE, WRITE_OWNER, READ/WRITE_NAMED_ATTRS,
+ * READ_ATTRIBUTES, READ_ACL) are currently unenforceable and don't translate
+ * to traditional read/write/execute permissions.
+ *
+ * It's problematic to reject acls that use certain mode bits, because it
+ * places the burden on users to learn the rules about which bits one
+ * particular server sets, without giving the user a lot of help--we return an
+ * error that could mean any number of different things.  To make matters
+ * worse, the problematic bits might be introduced by some application that's
+ * automatically mapping from some other acl model.
+ *
+ * So wherever possible we accept anything, possibly erring on the side of
+ * denying more permissions than necessary.
+ *
+ * However we do reject *explicit* DENY's of a few bits representing
+ * permissions we could never deny:
+ */
 
-	/* groups (mask and allow aces) */
+static inline int check_deny(u32 mask, int isowner)
+{
+	if (mask & (NFS4_ACE_READ_ATTRIBUTES | NFS4_ACE_READ_ACL))
+		return -EINVAL;
+	if (!isowner)
+		return 0;
+	if (mask & (NFS4_ACE_WRITE_ATTRIBUTES | NFS4_ACE_WRITE_ACL))
+		return -EINVAL;
+	return 0;
+}
 
-	while (ace2type(ace) == ACL_GROUP) {
-		if (*mask_ace == NULL)
-			goto out;
+static struct posix_acl *
+posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
+{
+	struct posix_acl_entry *pace;
+	struct posix_acl *pacl;
+	int nace;
+	int i, error = 0;
 
-		if (ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE ||
-			!MASK_EQUAL(ace->access_mask, (*mask_ace)->access_mask))
-			goto out;
-		*mask_ace = ace;
+	nace = 4 + state->users->n + state->groups->n;
+	pacl = posix_acl_alloc(nace, GFP_KERNEL);
+	if (!pacl)
+		return ERR_PTR(-ENOMEM);
 
-		ace = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace == NULL)
-			goto out;
-		ac = kmalloc(sizeof(*ac), GFP_KERNEL);
-		error = -ENOMEM;
-		if (ac == NULL)
-			goto out;
-		error = -EINVAL;
-		if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE ||
-				!same_who(ace, *mask_ace))
-			goto out;
+	pace = pacl->a_entries;
+	pace->e_tag = ACL_USER_OBJ;
+	error = check_deny(state->owner.deny, 1);
+	if (error)
+		goto out_err;
+	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags);
+	pace->e_id = ACL_UNDEFINED_ID;
 
-		ac->ace = ace;
-		list_add_tail(&ac->ace_l, &group_l);
+	for (i=0; i < state->users->n; i++) {
+		pace++;
+		pace->e_tag = ACL_USER;
+		error = check_deny(state->users->aces[i].perms.deny, 0);
+		if (error)
+			goto out_err;
+		low_mode_from_nfs4(state->users->aces[i].perms.allow,
+					&pace->e_perm, flags);
+		pace->e_id = state->users->aces[i].uid;
+		add_to_mask(state, &state->users->aces[i].perms);
+	}
+
+	pace++;
+	pace->e_tag = ACL_GROUP_OBJ;
+	error = check_deny(state->group.deny, 0);
+	if (error)
+		goto out_err;
+	low_mode_from_nfs4(state->group.allow, &pace->e_perm, flags);
+	pace->e_id = ACL_UNDEFINED_ID;
+	add_to_mask(state, &state->group);
+
+	for (i=0; i < state->groups->n; i++) {
+		pace++;
+		pace->e_tag = ACL_GROUP;
+		error = check_deny(state->groups->aces[i].perms.deny, 0);
+		if (error)
+			goto out_err;
+		low_mode_from_nfs4(state->groups->aces[i].perms.allow,
+					&pace->e_perm, flags);
+		pace->e_id = state->groups->aces[i].uid;
+		add_to_mask(state, &state->groups->aces[i].perms);
+	}
+
+	pace++;
+	pace->e_tag = ACL_MASK;
+	low_mode_from_nfs4(state->mask.allow, &pace->e_perm, flags);
+	pace->e_id = ACL_UNDEFINED_ID;
+
+	pace++;
+	pace->e_tag = ACL_OTHER;
+	error = check_deny(state->other.deny, 0);
+	if (error)
+		goto out_err;
+	low_mode_from_nfs4(state->other.allow, &pace->e_perm, flags);
+	pace->e_id = ACL_UNDEFINED_ID;
 
-		error = write_pace(ace, pacl, pace, ACL_GROUP, flags);
-		if (error < 0)
-			goto out;
-		error = -EINVAL;
-		ace = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace == NULL)
-			goto out;
-	}
+	return pacl;
+out_err:
+	posix_acl_release(pacl);
+	return ERR_PTR(error);
+}
 
-	/* group owner (deny ace) */
+static inline void allow_bits(struct posix_ace_state *astate, u32 mask)
+{
+	/* Allow all bits in the mask not already denied: */
+	astate->allow |= mask & ~astate->deny;
+}
 
-	if (ace2type(ace) != ACL_GROUP_OBJ)
-		goto out;
-	ac = list_entry(group_l.next, struct ace_container, ace_l);
-	ace2 = ac->ace;
-	if (!complementary_ace_pair(ace2, ace, flags))
-		goto out;
-	list_del(group_l.next);
-	kfree(ac);
+static inline void deny_bits(struct posix_ace_state *astate, u32 mask)
+{
+	/* Deny all bits in the mask not already allowed: */
+	astate->deny |= mask & ~astate->allow;
+}
 
-	/* groups (deny aces) */
+static int find_uid(struct posix_acl_state *state, struct posix_ace_state_array *a, uid_t uid)
+{
+	int i;
 
-	while (!list_empty(&group_l)) {
-		ace = get_next_v4_ace(p, &n4acl->ace_head);
-		if (ace == NULL)
-			goto out;
-		if (ace2type(ace) != ACL_GROUP)
-			goto out;
-		ac = list_entry(group_l.next, struct ace_container, ace_l);
-		ace2 = ac->ace;
-		if (!complementary_ace_pair(ace2, ace, flags))
-			goto out;
-		list_del(group_l.next);
-		kfree(ac);
-	}
+	for (i = 0; i < a->n; i++)
+		if (a->aces[i].uid == uid)
+			return i;
+	/* Not found: */
+	a->n++;
+	a->aces[i].uid = uid;
+	a->aces[i].perms.allow = state->everyone.allow;
+	a->aces[i].perms.deny  = state->everyone.deny;
 
-	ace = get_next_v4_ace(p, &n4acl->ace_head);
-	if (ace == NULL)
-		goto out;
-	if (ace2type(ace) != ACL_OTHER)
-		goto out;
-	error = 0;
-out:
-	while (!list_empty(&group_l)) {
-		ac = list_entry(group_l.next, struct ace_container, ace_l);
-		list_del(group_l.next);
-		kfree(ac);
-	}
-	return error;
+	return i;
 }
 
-static inline int
-mask_from_v4(struct nfs4_acl *n4acl, struct list_head **p,
-		struct nfs4_ace **mask_ace,
-		struct posix_acl *pacl, struct posix_acl_entry **pace,
-		unsigned int flags)
+static void deny_bits_array(struct posix_ace_state_array *a, u32 mask)
 {
-	int error = -EINVAL;
-	struct nfs4_ace *ace;
+	int i;
 
-	ace = list_entry(*p, struct nfs4_ace, l_ace);
-	if (pacl->a_count != 3) {
-		if (*mask_ace == NULL)
-			goto out;
-		(*mask_ace)->access_mask = deny_mask((*mask_ace)->access_mask, flags);
-		write_pace(*mask_ace, pacl, pace, ACL_MASK, flags);
-	}
-	error = 0;
-out:
-	return error;
+	for (i=0; i < a->n; i++)
+		deny_bits(&a->aces[i].perms, mask);
 }
 
-static inline int
-other_from_v4(struct nfs4_acl *n4acl, struct list_head **p,
-		struct posix_acl *pacl, struct posix_acl_entry **pace,
-		unsigned int flags)
+static void allow_bits_array(struct posix_ace_state_array *a, u32 mask)
 {
-	int error = -EINVAL;
-	struct nfs4_ace *ace, *ace2;
+	int i;
 
-	ace = list_entry(*p, struct nfs4_ace, l_ace);
-	if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE)
-		goto out;
-	error = write_pace(ace, pacl, pace, ACL_OTHER, flags);
-	if (error < 0)
-		goto out;
-	error = -EINVAL;
-	ace2 = get_next_v4_ace(p, &n4acl->ace_head);
-	if (ace2 == NULL)
-		goto out;
-	if (!complementary_ace_pair(ace, ace2, flags))
-		goto out;
-	error = 0;
-out:
-	return error;
+	for (i=0; i < a->n; i++)
+		allow_bits(&a->aces[i].perms, mask);
 }
 
-static int
-calculate_posix_ace_count(struct nfs4_acl *n4acl)
+static void process_one_v4_ace(struct posix_acl_state *state,
+				struct nfs4_ace *ace)
 {
-	if (n4acl->naces == 6) /* owner, owner group, and other only */
-		return 3;
-	else { /* Otherwise there must be a mask entry. */
-		/* Also, the remaining entries are for named users and
-		 * groups, and come in threes (mask, allow, deny): */
-		if (n4acl->naces < 7)
-			return -EINVAL;
-		if ((n4acl->naces - 7) % 3)
-			return -EINVAL;
-		return 4 + (n4acl->naces - 7)/3;
+	u32 mask = ace->access_mask;
+	int i;
+
+	switch (ace2type(ace)) {
+	case ACL_USER_OBJ:
+		if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
+			allow_bits(&state->owner, mask);
+		} else {
+			deny_bits(&state->owner, mask);
+		}
+		break;
+	case ACL_USER:
+		i = find_uid(state, state->users, ace->who);
+		if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
+			allow_bits(&state->users->aces[i].perms, mask);
+		} else {
+			deny_bits(&state->users->aces[i].perms, mask);
+			mask = state->users->aces[i].perms.deny;
+			deny_bits(&state->owner, mask);
+		}
+		break;
+	case ACL_GROUP_OBJ:
+		if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
+			allow_bits(&state->group, mask);
+		} else {
+			deny_bits(&state->group, mask);
+			mask = state->group.deny;
+			deny_bits(&state->owner, mask);
+			deny_bits(&state->everyone, mask);
+			deny_bits_array(state->users, mask);
+			deny_bits_array(state->groups, mask);
+		}
+		break;
+	case ACL_GROUP:
+		i = find_uid(state, state->groups, ace->who);
+		if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
+			allow_bits(&state->groups->aces[i].perms, mask);
+		} else {
+			deny_bits(&state->groups->aces[i].perms, mask);
+			mask = state->groups->aces[i].perms.deny;
+			deny_bits(&state->owner, mask);
+			deny_bits(&state->group, mask);
+			deny_bits(&state->everyone, mask);
+			deny_bits_array(state->users, mask);
+			deny_bits_array(state->groups, mask);
+		}
+		break;
+	case ACL_OTHER:
+		if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
+			allow_bits(&state->owner, mask);
+			allow_bits(&state->group, mask);
+			allow_bits(&state->other, mask);
+			allow_bits(&state->everyone, mask);
+			allow_bits_array(state->users, mask);
+			allow_bits_array(state->groups, mask);
+		} else {
+			deny_bits(&state->owner, mask);
+			deny_bits(&state->group, mask);
+			deny_bits(&state->other, mask);
+			deny_bits(&state->everyone, mask);
+			deny_bits_array(state->users, mask);
+			deny_bits_array(state->groups, mask);
+		}
 	}
 }
 
-
 static struct posix_acl *
 _nfsv4_to_posix_one(struct nfs4_acl *n4acl, unsigned int flags)
 {
+	struct posix_acl_state state;
 	struct posix_acl *pacl;
-	int error = -EINVAL, nace = 0;
-	struct list_head *p;
-	struct nfs4_ace *mask_ace = NULL;
-	struct posix_acl_entry *pace;
-
-	nace = calculate_posix_ace_count(n4acl);
-	if (nace < 0)
-		goto out_err;
-
-	pacl = posix_acl_alloc(nace, GFP_KERNEL);
-	error = -ENOMEM;
-	if (pacl == NULL)
-		goto out_err;
+	struct nfs4_ace *ace;
+	int ret;
 
-	pace = &pacl->a_entries[0];
-	p = &n4acl->ace_head;
+	ret = init_state(&state, n4acl->naces);
+	if (ret)
+		return ERR_PTR(ret);
 
-	error = user_obj_from_v4(n4acl, &p, pacl, &pace, flags);
-	if (error)
-		goto out_acl;
+	list_for_each_entry(ace, &n4acl->ace_head, l_ace)
+		process_one_v4_ace(&state, ace);
 
-	error = users_from_v4(n4acl, &p, &mask_ace, pacl, &pace, flags);
-	if (error)
-		goto out_acl;
+	pacl = posix_state_to_acl(&state, flags);
 
-	error = group_obj_and_groups_from_v4(n4acl, &p, &mask_ace, pacl, &pace,
-						flags);
-	if (error)
-		goto out_acl;
+	free_state(&state);
 
-	error = mask_from_v4(n4acl, &p, &mask_ace, pacl, &pace, flags);
-	if (error)
-		goto out_acl;
-	error = other_from_v4(n4acl, &p, pacl, &pace, flags);
-	if (error)
-		goto out_acl;
-
-	error = -EINVAL;
-	if (p->next != &n4acl->ace_head)
-		goto out_acl;
-	if (pace != pacl->a_entries + pacl->a_count)
-		goto out_acl;
-
-	sort_pacl(pacl);
-
-	return pacl;
-out_acl:
-	posix_acl_release(pacl);
-out_err:
-	pacl = ERR_PTR(error);
+	if (!IS_ERR(pacl))
+		sort_pacl(pacl);
 	return pacl;
 }
 
@@ -785,6 +717,10 @@ nfs4_acl_split(struct nfs4_acl *acl, str
 	list_for_each_safe(h, n, &acl->ace_head) {
 		ace = list_entry(h, struct nfs4_ace, l_ace);
 
+		if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
+		    ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
+			return -EINVAL;
+
 		if ((ace->flag & NFS4_INHERITANCE_FLAGS)
 				!= NFS4_INHERITANCE_FLAGS)
 			continue;
@@ -930,23 +866,6 @@ nfs4_acl_write_who(int who, char *p)
 	return -1;
 }
 
-static inline int
-match_who(struct nfs4_ace *ace, uid_t owner, gid_t group, uid_t who)
-{
-	switch (ace->whotype) {
-		case NFS4_ACL_WHO_NAMED:
-			return who == ace->who;
-		case NFS4_ACL_WHO_OWNER:
-			return who == owner;
-		case NFS4_ACL_WHO_GROUP:
-			return who == group;
-		case NFS4_ACL_WHO_EVERYONE:
-			return 1;
-		default:
-			return 0;
-	}
-}
-
 EXPORT_SYMBOL(nfs4_acl_new);
 EXPORT_SYMBOL(nfs4_acl_free);
 EXPORT_SYMBOL(nfs4_acl_add_ace);
