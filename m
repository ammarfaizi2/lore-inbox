Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUKODNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUKODNC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUKODML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:12:11 -0500
Received: from almesberger.net ([63.105.73.238]:63236 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261481AbUKODFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:05:17 -0500
Date: Mon, 15 Nov 2004 00:05:06 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] prio_tree debugging functions (3/3)
Message-ID: <20041115000506.B23273@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <20041114235936.A23273@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114235936.A23273@almesberger.net>; from werner@almesberger.net on Sun, Nov 14, 2004 at 11:59:36PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The third and last part, which actually contains new code: debugging
functions for radix priority search trees. They're useful if some bug
happens to mess up the RPST, and you have no clue what is going on.
(Particularly since the RPST isn't exactly the most trivial data
structure either ;-)

I'd just add this to lib/prio_tree.c. Since I don't like overlapping
patches, this isn't in the form of a patch. I'll make one for
submission to mainline.

- Werner

---------------------------------- cut here -----------------------------------

/*
 * The following functions validate the internal consistency of an RPST. They
 * all have O(n) run time, so use them only on small trees, or in emergencies.
 *
 * prio_tree_validate_tree validates the internal consistency of an RPST.
 *
 * prio_tree_absent checks that no tree node points to the "absentee" node.
 *
 * prio_tree_string turns the tree into a nested list and prints it into a
 * string buffer.
 */


#ifdef PRIO_TREE_DEBUG

#define CHECK_BUG(cond) \
	if (cond) { \
		printk(KERN_EMERG #cond "\n"); \
		return -1; \
 	}


enum prio_tree_walk_state {
	prio_tree_walk_down,
	prio_tree_walk_left,
	prio_tree_walk_right,
};


static int prio_tree_validate_child(const struct prio_tree_node *node,
    int right, int bit, int in_size)
{
	unsigned long r_parent, h_parent;
	unsigned long r_child, h_child;
	unsigned long i_parent,i_child;

	GET_INDEX(node->parent, r_parent, h_parent);
	GET_INDEX(node, r_child, h_child);

	CHECK_BUG(r_child > h_child);	/* left edge > right edge */
	CHECK_BUG(h_parent < h_child);	/* sort order wrong */

	if (in_size) {
		i_parent = r_parent;
		i_child = r_child;
	}
	else {
		i_parent = h_parent-r_parent;
		i_child = h_child-r_child;
	}

	/*
	 * Parent and child can differ only in the lower "bit" bits. Also, the
	 * value of the next bit is determined by the branch we're taking.
	 */
	CHECK_BUG(i_parent >> bit != i_child >> bit);
	CHECK_BUG(((i_child >> (bit-1)) & 1) != right);

	return 0;
}


static int do_prio_tree_validate(const struct prio_tree_node *node, int bits)
{
	enum prio_tree_walk_state state = prio_tree_walk_down;
	int bit = bits;
	int in_start = 1;
	int bad;

	while (1) {
		switch (state) {
			/*
			 * The tree is an RPST keyed by (start,end) down to
			 * individual start locations. Then it changes to an
			 * RPST keyed by (size,end).
			 */
			case prio_tree_walk_down:
				if (!prio_tree_left_empty(node)) {
					if (!bit) {
						CHECK_BUG(!in_start);
						bit = bits;
						in_start = 0;
					}
					CHECK_BUG(node->left->parent != node);

					node = node->left;
					bad = prio_tree_validate_child(node, 0,
					    bit, in_start);
					if (bad)
						return bad;
					bit--;
					break;
				}
				/* fall through */
			case prio_tree_walk_left:
				if (!prio_tree_right_empty(node)) {
					if (!bit) {
						CHECK_BUG(!in_start);
						bit = bits;
						in_start = 0;
					}
					CHECK_BUG(node->right->parent != node);

					node = node->right;
					bad = prio_tree_validate_child(node, 1,
					    bit, in_start);
					if (bad)
						return bad;
					state = prio_tree_walk_down;
					bit--;
					break;
				}
				/* fall through */
			case prio_tree_walk_right:
				if (prio_tree_root(node))
					return 0;
				state = node->parent->left == node ?
				    prio_tree_walk_left : prio_tree_walk_right;
				node = node->parent;
				bit++;
				if (bit == bits && !in_start) {
					bit = 0;
					in_start = 1;
				}
				break;
			default:
				BUG();
		}
	}
	return 0;
}


/*
 * We use a slightly different algorithm than the one found in
 * abiss_prio_tree_init on purpose.
 */

static int prio_tree_validate_index_map(void)
{
	const unsigned long *p;

	for (p = prio_tree_index_bits_to_maxindex;
	    p != (void *) prio_tree_index_bits_to_maxindex+
	    sizeof(prio_tree_index_bits_to_maxindex); p++) {
		int n = p-prio_tree_index_bits_to_maxindex;

		CHECK_BUG(*p != ((((1UL << n)-1) << 1) | 1));
	}
	return 0;
}


int prio_tree_validate(const struct prio_tree_root *root)
{
	unsigned long r_root, h_root;
	int bad;

	bad = prio_tree_validate_index_map();
	if (bad)
		return bad;

	if (prio_tree_empty(root))
		return 0;

	CHECK_BUG(!root->index_bits);
	CHECK_BUG(root->index_bits > sizeof(unsigned long)*8);

	/*
	 * Check the root node now, so that we don't have to check parent and
	 * child everywhere on the way down the tree.
	 */
	GET_INDEX(root->prio_tree_node, r_root, h_root);
	CHECK_BUG(r_root > h_root);
	CHECK_BUG(!prio_tree_root(root->prio_tree_node));

	return do_prio_tree_validate(root->prio_tree_node, root->index_bits);
}

#undef CHECK_BUG


static void do_prio_tree_absent(const struct prio_tree_node *node,
    const struct prio_tree_node *absentee)
{
	enum prio_tree_walk_state state = prio_tree_walk_down;

	while (1) {
		BUG_ON(node == absentee);
		switch (state) {
			case prio_tree_walk_down:
				if (!prio_tree_left_empty(node)) {
					node = node->left;
					break;
				}
				/* fall through */
			case prio_tree_walk_left:
				if (!prio_tree_right_empty(node)) {
					state = prio_tree_walk_down;
					node = node->right;
					break;
				}
				/* fall through */
			case prio_tree_walk_right:
				if (prio_tree_root(node))
					return;
				state = node->parent->left == node ?
				    prio_tree_walk_left : prio_tree_walk_right;
				node = node->parent;
				break;
			default:
				BUG();
		}
	}
}


void prio_tree_absent(const struct prio_tree_root *root,
    const struct prio_tree_node *absentee)
{
	if (prio_tree_empty(root))
		return;
	do_prio_tree_absent(root->prio_tree_node, absentee);
}


static void do_prio_tree_string(const struct prio_tree_node *node, char **buf,
     const char *end)
{
	enum prio_tree_walk_state state = prio_tree_walk_down;
	unsigned long r_index, h_index;
	int len;

	while (1) {
		GET_INDEX(node, r_index, h_index);
		switch (state) {
			case prio_tree_walk_down:
				len = scnprintf(*buf, end-*buf,
				    "(%lu[0x%lx] %lu,", r_index, r_index,
				    h_index);
				BUG_ON(len+1 == end-*buf);
				*buf += len;
				if (!prio_tree_left_empty(node)) {
					node = node->left;
					break;
				}
				/* fall through */
			case prio_tree_walk_left:
				BUG_ON(*buf == end);
				*(*buf)++ = ',';
				if (!prio_tree_right_empty(node)) {
					state = prio_tree_walk_down;
					node = node->right;
					break;
				}
				/* fall through */
			case prio_tree_walk_right:
				BUG_ON(*buf == end);
				*(*buf)++ = ')';
				if (prio_tree_root(node))
					return;
				state = node->parent->left == node ?
				    prio_tree_walk_left : prio_tree_walk_right;
				node = node->parent;
				break;
			default:
				BUG();
		}
	}
}


int prio_tree_string(const struct prio_tree_root *root, char *buf, size_t size)
{
	const char *start = buf;
	int len;

	len = scnprintf(buf, size, "%d@%p:", root->index_bits, root);
	BUG_ON(len+1 == size);
	buf += len;
	if (!prio_tree_empty(root))
		do_prio_tree_string(root->prio_tree_node, &buf, start+size);
	BUG_ON(buf == start+size);
	*buf = 0;
	return buf-start;
}


#else

#define prio_tree_validate(root)
#define prio_tree_absent(root, absentee)
#define prio_tree_string(root, buf, size) (*(buf) = 0)

#endif

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
