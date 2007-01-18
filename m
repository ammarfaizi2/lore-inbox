Return-Path: <linux-kernel-owner+w=401wt.eu-S932539AbXARUdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbXARUdu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbXARUdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:33:50 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34132
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932539AbXARUdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:33:49 -0500
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Documentation/rbtree.txt
Date: Thu, 18 Jan 2007 15:33:25 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701181533.25318.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Landley <rob@landley.net>

Documentation for lib/rbtree.c.

--

I'm not an expert on this but I was asked to write up some documentation
for rbtree in the Linux kernel, and as long as it's there...

I'm sure if I screwed something up somebody will point it out to me, loudly.
:)

--- /dev/null	2006-05-30 21:33:22.000000000 -0400
+++ linux-2.6.19.2/Documentation/rbtree.txt	2007-01-18 11:57:50.000000000 -0500
@@ -0,0 +1,186 @@
+Red-black Trees (rbtree) in Linux
+January 18, 2007
+Rob Landley <rob@landley.net>
+=============================
+
+What are red-black trees, and what are they for?
+------------------------------------------------
+
+Red-black trees are a type of self-balancing binary search tree, used for
+storing sortable key/value data pairs.  This differs from radix trees (which
+are used to efficiently store sparse arrays and thus use long integer indexes
+to insert/access/delete nodes) and hash tables (which are not kept sorted to
+be easily traversed in order, and must be tuned for a specific size and
+hash function where rbtrees scale gracefully storing arbitrary keys).
+
+Red-black trees are similar to AVL trees, but provide faster realtime bounded
+worst case performance for insertion and deletion (at most two rotations and
+three rotations, respectively, to balance the tree), with slightly slower
+(but still O(log n)) lookup time.
+
+To quote Linux Weekly News:
+
+    There are a number of red-black trees in use in the kernel.
+    The anticipatory, deadline, and CFQ I/O schedulers all employ
+    rbtrees to track requests; the packet CD/DVD driver does the same.
+    The high-resolution timer code uses an rbtree to organize outstanding
+    timer requests.  The ext3 filesystem tracks directory entries in a
+    red-black tree.  Virtual memory areas (VMAs) are tracked with red-black
+    trees, as are epoll file descriptors, cryptographic keys, and network
+    packets in the "hierarchical token bucket" scheduler.
+
+This document covers use of the Linux rbtree implementation.  For more
+information on the nature and implementation of Red Black Trees,  see:
+
+  Linux Weekly News article on red-black trees
+    http://lwn.net/Articles/184495/
+
+  Wikipedia entry on red-black trees
+    http://en.wikipedia.org/wiki/Red-black_tree
+
+Linux implementation of red-black trees
+---------------------------------------
+
+Linux's rbtree implementation lives in the file "lib/rbtree.c".  To use it,
+"#include <linux/rbtree.h>".
+
+The Linux rbtree implementation is optimized for speed, and thus has one
+less layer of indirection (and better cache locality) than more traditional
+tree implementations.  Instead of using pointers to separate rb_node and data
+structures, each instance of struct rb_node is embedded in the data structure
+it organizes.  And instead of using a comparison callback function pointer,
+users are expected to write their own tree search and insert functions
+which call the provided rbtree functions.  Locking is also left up to the
+user of the rbtree code.
+
+Creating a new rbtree
+---------------------
+
+Data nodes in an rbtree tree are structures containing a struct rb_node member:
+
+  struct mytype {
+  	struct rb_node node;
+  	char *keystring;
+  };
+
+When dealing with a pointer to the embedded struct rb_node, the containing data
+structure may be accessed with the standard container_of() macro.  In addition,
+individual members may be accessed directly via rb_entry(node, type, member).
+
+At the root of each rbtree is a rb_root structure, which is initialized to be
+empty via:
+
+  struct rb_root mytree = RB_ROOT;
+
+Searching for a value in an rbtree
+----------------------------------
+
+Writing a search function for your tree is fairly straightforward: start at the
+root, compare each value, and follow the left or right branch as necessary.
+
+Example:
+
+  struct mytype *my_search(struct rb_root *root, char *string)
+  {
+  	struct rb_node *node = root->rb_node;
+
+  	while (node) {
+  		struct mytype *data = container_of(node, struct mytype, node);
+		int result;
+
+		result = strcmp(string, data->keystring);
+
+		if (result < 0) node = node->rb_left;
+		else if (result > 0) node = node->rb_right;
+		else return data;
+	}
+	return NULL;
+  }
+
+Inserting data into an rbtree
+-----------------------------
+
+Inserting data in the tree involves first searching for the place to insert the
+new node, then inserting the node and rebalancing ("recoloring") the tree.
+
+The search for insertion differs from the previous search by finding the
+location of the pointer on which to graft the new node.  The new node also
+needs a link to its' parent node for rebalancing purposes.
+
+Example:
+
+  int my_insert(struct rb_root *root, struct mytype *data)
+  { 
+  	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+  	// Figure out where to put new node
+  	while (*new) {
+  		struct mytype *this = container_of(*new, struct mytype, node);
+  		int result = strcmp(data->keystring, this->keystring);
+
+		parent = *new;
+  		if (result < 0) new = &((*new)->rb_left);
+  		else if (result > 0) new = &((*new)->rb_right);
+  		else return FALSE;
+  	}
+
+  	// Add new node and rebalance tree.
+  	rb_link_node(data->node, parent, new);
+  	rb_insert_color(data->node, root);
+
+	return TRUE;
+  }
+
+Removing or replacing existing data in an rbtree
+------------------------------------------------
+
+To remove an existing node from a tree, call:
+
+  void rb_erase(struct rb_node *victim, struct rb_root *tree);
+
+Example:
+
+  struct mytype *data = mysearch(mytree, "walrus");
+
+  if (data) {
+  	rb_erase(data->node, mytree);
+  	myfree(data);
+  }
+
+To replace an existing node in a tree with a new one with the same key, call:
+
+  void rb_replace_node(struct rb_node *old, struct rb_node *new,
+  			struct rb_root *tree);
+
+Replacing a node this way does not re-sort the tree: If the new node doesn't
+have the same key as the old node, the rbtree will probably become corrupted.
+
+Iterating through the elements stored in an rbtree (in sort order)
+------------------------------------------------------------------
+
+Four functions are provided for iterating through an rbtree's contents in
+sorted order.  These work on arbitrary trees, and should not need to be
+modified or wrapped (except for locking purposes):
+
+  struct rb_node *rb_first(struct rb_root *tree);
+  struct rb_node *rb_last(struct rb_root *tree);
+  struct rb_node *rb_next(struct rb_node *node);
+  struct rb_node *rb_prev(struct rb_node *node);
+
+To start iterating, call rb_first() or rb_last() with a pointer to the root
+fo the tree, which will return a pointer to the node structure contained in
+the first or last element in the tree.  To continue, fetch the next or previous
+node by calling rb_next() or rb_prev() on the current node.  This will return
+NULL when there are no more nodes left.
+
+The iterator functions return a pointer to the embedded struct rb_node, from
+which the containing data structure may be accessed with the container_of()
+macro, and individual members may be accessed directly via
+rb_entry(node, type, member).
+
+Example:
+
+  struct rb_node *node;
+  for (node = rb_first(&mytree); node; node = rb_next(node))
+  	printk("key=%s\n", rb_entry(node, int, keystring));
+


-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
